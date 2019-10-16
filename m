Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5741DA240
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2019 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438694AbfJPXdr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 19:33:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34591 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbfJPXdr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Oct 2019 19:33:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so187062pll.1;
        Wed, 16 Oct 2019 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uh+Y61FIuHN11ISk5EOVmKLQiLwCogVrs+eoUekVmbI=;
        b=E4oqhMJ1fkqY/nLBITYRXBbOjqI9ON1Q10rXROB3hT0lUN+Jgf/PA36PavG2+dwmwt
         dsaXeSWss5XL2F2+DtQqVbc02C1kK2HNTYq7zpIJLUngiGQzTirMOC4/cvsmNneyct5I
         bo5YAEnPLSeghUTOs4fEo2Gs6j9nUNd93vW3iVDBLqsQhBM3ovr9dC22IF8mPeZGv5pf
         du8wuRd0rvlpQ2EKADoKgrPqGmi/XkdPBoJUFWigIjBNMOVj4YQs/SzM1KgVo9WB89+4
         lhrQ1EJFvrYnaxf7ulXiQm3yXCnm051u0r586KHq05nY8O0eMJ2PdxVTfx9B7I8QGDg/
         IqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uh+Y61FIuHN11ISk5EOVmKLQiLwCogVrs+eoUekVmbI=;
        b=mMGHVZKaKyswjrDNqfctwS147y2ofGblUDnY42MXu9GLXt8M0363I5oVRlFrlsiZ2R
         HRl0LCfpfSkw4xnsULKC1ZUdnWph2jTeGNn4LZrOOdPithiyn0VrQBJcjfxocpFmTggc
         ye8lcZHG050Y47DjO0XeMKpUYl6B22fN8rJqGsQ3w68MYSjDr66jIDCE9Ntvn4oTZWVK
         E4A7brsJAq+wGkmX6clScimjbGjwBTZK9S/U1L+lF467+A34hCJZPk42TgkPyRhR1s3y
         3ZXFTrPXrV2DushQ2RbDheBAa1T8xM/paQfLkk69ey0KcjnOJb30Um4tt3oOqhVP2LY6
         S8uQ==
X-Gm-Message-State: APjAAAUUepa1Ce0amrEsxzS6pk9oa5kucrXOj99vdYEm8ZxFO8diAl7X
        EOSqZHzKB7Gn0NGJTqsUDDc=
X-Google-Smtp-Source: APXvYqwAUpwEd27UuLkUyCjrYO6Q7JAFflB2zGWMEFUWNVDOWgFS4sWp+jKLbkK6PDMu6E4vtaW+hw==
X-Received: by 2002:a17:902:7798:: with SMTP id o24mr843574pll.108.1571268826019;
        Wed, 16 Oct 2019 16:33:46 -0700 (PDT)
Received: from gmail.com ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id s18sm227268pji.30.2019.10.16.16.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:33:44 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:33:42 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv7 01/33] ns: Introduce Time Namespace
Message-ID: <20191016233342.GA3075@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-2-dima@arista.com>
 <80af93da-d497-81de-2a2a-179bb3bc852d@arm.com>
 <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 16, 2019 at 12:39:11PM +0200, Thomas Gleixner wrote:
> On Wed, 16 Oct 2019, Vincenzo Frascino wrote:
> 
> < Trim 250+ lines ( 3+ pages) of pointlessly wasted electrons >
> 
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1096,6 +1096,13 @@ config UTS_NS
> > >  	  In this namespace tasks see different info provided with the
> > >  	  uname() system call
> > >  
> > > +config TIME_NS
> > > +	bool "TIME namespace"
> > > +	default y
> > 
> > Having CONFIG_TIME_NS "default y" makes so that the option is selected even on
> > the architectures that have no support for time namespaces.
> > The direct consequence is that the fallbacks defined in this patch are never
> > selected and this ends up in kernel compilation errors due to missing symbols.
> > 
> > The error below shows what happens on arm64 (similar behavior on other
> > architectures):
> > 
> > aarch64-linux-gnu-ld: kernel/time/namespace.o: in function `timens_on_fork':
> > kernel/time/namespace.c:321: undefined reference to `vdso_join_timens'
> > 
> > My proposal is to keep TIME_NS "default n" (just remove "default y"), let the
> > architectures that enable time namespaces select it and make CONFIG_TIME_NS
> > select GENERIC_VDSO_TIME_NS if arch has HAVE_GENERIC_VDSO.
> 
> Nah.
> 
> config TIME_NS
> 	bool "TIME namespace"
> 	depends on GENERIC_VDSO_TIME_NS

I was thinking to fix this by the same way with a small difference.

If GENERIC_GETTIMEOFDAY isn't set, it should be safe to allow enabling
TIME_NS. In this case, clock_gettime works via system call and we don't
have arch-specific code in this case. Does this sound reasonable?

        depends on (!GENERIC_GETTIMEOFDAY || GENERIC_VDSO_TIME_NS)

Thanks,
Andrei
