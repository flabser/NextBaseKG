(function(){var l={Version:"7.1.4982.17897"};window.cfx.Bullet=l;var m=window.cfx,c=window.sfx,i=function k(){k._ic();this.a=this.b=0};i.prototype={_i:function(){this.a=this.b=0},_0dM:function(){this._i();return this},d:function(c,b,d){c.a=d+b*this.b;c.b=b-b*this.a},c:function(k){this.a=1-c.a.o(100,c.a.n(0,k))/100;this.b=this.a/2},_cf:function(c){this.b=c.b;this.a=c.a;return this},_nc:function(){var c=new i;c._cf(this);return c}};i._dt("CWGV",c.W,0);var j=function b(){b._ic();this.f=0;this._0Bullet()};
l.Bullet=j;j.prototype={_0Bullet:function(){this.g=new i;this.e=new i;this.c=60;this.b=100;this.a=0;return this},getActualVolume:function(){return this.c},setActualVolume:function(b){this.c=b},getTargetVolume:function(){return this.b},setTargetVolume:function(b){this.b=b},reset:function(){},icV:function(){return 2},icW:function(){return 268964E3},icU:function(b,c,a){switch(c){case 5:return"%s %v\n%s2 %v~";case 11:return this.h(a)}return null},icX:function(b,d,a){b.b=1;b.a=0;a.e==a.m&&((a.d==a.p&&
(this.g.c(this.c),this.e.c(this.b),this.a=a.m_bDetecting?1:0),0==this.a)?this.f=c.u.z(a.d,2):1==this.a&&(a.b.a.b=!1));var b=a.K,g=a.ae,d=a.H,e=a.y,h=a.Y,i=this.f,f=c.u.z(a.af-g+1,2),e=e+a.a.j*f,f=0;1<h?(f=e+a.a.j*j.d(i+1,g,h),e+=a.a.j*j.d(i,g,h),f=c.a.d(f-e)):f=g;g=e-f;0==this.a?(h=new c._p2(0,0),this.g.d(h,f,g),g=h.a,h=h.b,b=(new c.c)._02c(d,g,b-d,h),a.c.idP(a.x,b),a.y=e+c.u.z(a.a.j*f,2),a.aP(),a.m_bDetecting&&a.detectCheck()&&a.bu--):1==this.a&&(d=new c._p2(0,0),this.e.d(d,f,g),e=d.a,d=d.b,a.c.idq(a.n,
b,e,b,e+d));a.e==a.o&&(this.a=0==this.a?1:0)},h:function(b){b.L=2;b.a.e=8;return null}};j.d=function(b,d,a){return c.u.z(b*d,a)};j._dt("CWGB",c.Sy,0,m.icT)})();