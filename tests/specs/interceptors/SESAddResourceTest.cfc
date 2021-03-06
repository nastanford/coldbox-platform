﻿component extends="coldbox.system.testing.BaseInterceptorTest" interceptor="coldbox.system.interceptors.SES"{

    function beforeAll() {
        super.setup();
        variables.ses = variables.interceptor;
    }

    function run() {
        describe( "Mapping resources", function(){
            
            beforeEach( function(){
                ses.$reset();
                ses.$("addRoute");
            } );

            it( "can add routes with restful flags for API resources", function(){
                ses.resources( resource="photos", restful=true );

                var cl = ses.$callLog().addRoute;

                expect( cl ).toHaveLength( 2, "addRoute should have been called 2 times, but it was called: #arrayLen( cl )#" );

                expect( cl[ 1 ] ).toBe( 
                    { 
                        pattern = "/photos/:id", 
                        handler = "photos", 
                        action  = { GET = "show", PUT = "update", PATCH = "update", POST = "update", DELETE = "delete" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 2 ] ).toBe( 
                    { 
                        pattern = "/photos", 
                        handler = "photos", 
                        action  = { GET = "index", POST = "create" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
            });

            it( "can add RESTFul routes as a string list", function(){
                ses.resources( "photos,users" );

                var cl = ses.$callLog().addRoute;

                expect( cl ).toHaveLength( 8, "addRoute should have been called 8 times, but it was called: #arrayLen( cl )#" );
            });

            it( "can add RESTFul routes as an array list", function(){
                ses.resources( [ "photos", "users" ] );

                var cl = ses.$callLog().addRoute;

                expect( cl ).toHaveLength( 8, "addRoute should have been called 8 times, but it was called: #arrayLen( cl )#" );
            });
            
            it( "can add all the RESTful routes for a resource", function() {
                ses.resources( "photos" );

                var cl = ses.$callLog().addRoute;

                expect( cl ).toHaveLength( 4, "addRoute should have been called 4 times" );
                expect( cl[ 1 ] ).toBe( 
                    { 
                        pattern = "/photos/:id/edit", 
                        handler = "photos", 
                        action  = { GET = "edit" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 2 ] ).toBe( 
                    { 
                        pattern = "/photos/new", 
                        handler = "photos", 
                        action  = { GET = "new" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 3 ] ).toBe( 
                    { 
                        pattern = "/photos/:id", 
                        handler = "photos", 
                        action = { GET = "show", PUT = "update", PATCH = "update", POST = "update", DELETE = "delete" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 4 ] ).toBe( 
                    { 
                        pattern = "/photos", 
                        handler = "photos", 
                        action  = { GET = "index", POST = "create" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
            } );

            it( "can override the handler used", function() {
                ses.resources( "photos", "PhotosController" );

                var cl = ses.$callLog().addRoute;
               // debug( cl );

                expect( cl ).toHaveLength( 4, "addRoute should have been called 4 times" );
                expect( cl[ 1 ] ).toBe( 
                    { 
                        pattern = "/photos/:id/edit", 
                        handler = "PhotosController", 
                        action = { GET = "edit" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 2 ] ).toBe( 
                    { 
                        pattern = "/photos/new", 
                        handler = "PhotosController", 
                        action = { GET = "new" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 3 ] ).toBe( 
                    { 
                        pattern = "/photos/:id", 
                        handler = "PhotosController", 
                        action = { GET = "show", PUT = "update", PATCH = "update", POST = "update", DELETE = "delete" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 4 ] ).toBe( 
                    { 
                        pattern = "/photos", 
                        handler = "PhotosController", 
                        action = { GET = "index", POST = "create" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
            } );

            it( "can override the parameterName used", function() {
                ses.resources( resource = "photos", parameterName = "photoId" );

                var cl = ses.$callLog().addRoute;
               // debug( cl );

                expect( cl ).toHaveLength( 4, "addRoute should have been called 4 times" );
                expect( cl[ 1 ] ).toBe( 
                    { 
                        pattern = "/photos/:photoId/edit", 
                        handler = "photos", 
                        action  = { GET = "edit" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 2 ] ).toBe( 
                    { 
                        pattern = "/photos/new", 
                        handler = "photos", 
                        action  = { GET = "new" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 3 ] ).toBe( 
                    { 
                        pattern = "/photos/:photoId", 
                        handler = "photos", 
                        action  = { GET = "show", PUT = "update", PATCH = "update", POST = "update", DELETE = "delete" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
                expect( cl[ 4 ] ).toBe( 
                    { 
                        pattern = "/photos", 
                        handler = "photos", 
                        action  = { GET = "index", POST = "create" },
                        module  = "",
                        namespace = ""
                    }, 
                    "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                );
            } );

            it( "returns itself to continue chaining", function() {
                var result = ses.resources( "photos" );

                expect( result ).toBe( ses );
            } );


            describe( "limiting the routes created by action", function() {
                describe( "using the `only` parameter", function() {
                    it( "can take a list of actions and only generate those routes", function() {
                        ses.resources( resource = "photos", only = "index,show" );

                        var cl = ses.$callLog().addRoute;
                       // debug( cl );

                        expect( cl ).toHaveLength( 2, "addRoute should have been called 2 times" );
                        expect( cl[ 1 ] )
                            .toBe( 
                                { pattern = "/photos/:id", handler = "photos", action = { GET = "show" }, module = "", namespace = "" }, 
                                "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                            );
                        expect( cl[ 2 ] )
                            .toBe( 
                                { pattern = "/photos", handler = "photos", action = { GET = "index" }, module = "", namespace = "" }, 
                                "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                            );
                    } );

                    it( "can take an array of actions and only generate those routes", function() {
                        ses.resources( resource = "photos", only = [ "index", "show" ] );

                        var cl = ses.$callLog().addRoute;
                       // debug( cl );

                        expect( cl ).toHaveLength( 2, "addRoute should have been called 2 times" );
                        expect( cl[ 1 ] ).toBe( 
                            { pattern = "/photos/:id", handler = "photos", action = { GET = "show" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                        expect( cl[ 2 ] ).toBe( 
                            { pattern = "/photos", handler = "photos", action = { GET = "index" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                    } );
                } );

                describe( "using the `except` parameter", function() {
                    it( "can take a list of actions and generate all except those routes", function() {
                        ses.resources( resource = "photos", except = "create,edit,update,delete" );

                        var cl = ses.$callLog().addRoute;
                       // debug( cl );

                        expect( cl ).toHaveLength( 3, "addRoute should have been called 3 times" );
                        expect( cl[ 1 ] ).toBe( 
                            { pattern = "/photos/new", handler = "photos", action = { GET = "new" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                        expect( cl[ 2 ] ).toBe( 
                            { pattern = "/photos/:id", handler = "photos", action = { GET = "show" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                        expect( cl[ 3 ] ).toBe( 
                            { pattern = "/photos", handler = "photos", action = { GET = "index" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                    } );

                    it( "can take an array of actions and generate all except those routes", function() {
                        ses.resources( resource = "photos", except = [ "create", "edit", "update", "delete" ] );

                        var cl = ses.$callLog().addRoute;
                       // debug( cl );

                        expect( cl ).toHaveLength( 3, "addRoute should have been called 3 times" );
                        expect( cl[ 1 ] ).toBe( 
                            { pattern = "/photos/new", handler = "photos", action = { GET = "new" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                        expect( cl[ 2 ] ).toBe( 
                            { pattern = "/photos/:id", handler = "photos", action = { GET = "show" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                        expect( cl[ 3 ] ).toBe( 
                            { pattern = "/photos", handler = "photos", action = { GET = "index" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                    } );
                } );

                describe( "using both `only` and `except`", function() {
                    it( "can apply both the `only` and the `except` parameters", function() {
                        ses.resources( resource = "photos", only = [ "index", "show" ], except = "show", module = "", namespace = "" );

                        var cl = ses.$callLog().addRoute;
                       // debug( cl );

                        expect( cl ).toHaveLength( 1, "addRoute should have been called 1 time" );
                        expect( cl[ 1 ] ).toBe( 
                            { pattern = "/photos", handler = "photos", action = { GET = "index" }, module = "", namespace = "" }, 
                            "The route did not match.  Remember that order matters.  Add the most specific routes first." 
                        );
                    } );
                } );
            } );

        } );
    }

}