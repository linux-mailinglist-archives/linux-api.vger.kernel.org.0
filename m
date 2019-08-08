Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12F8672D
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfHHQdy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 12:33:54 -0400
Received: from namei.org ([65.99.196.166]:39470 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQdy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 8 Aug 2019 12:33:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x78GXbYN032334;
        Thu, 8 Aug 2019 16:33:37 GMT
Date:   Fri, 9 Aug 2019 02:33:37 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V38 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
In-Reply-To: <20190808111246.GA29211@linux-8ccs>
Message-ID: <alpine.LRH.2.21.1908090232530.31143@namei.org>
References: <20190808000721.124691-1-matthewgarrett@google.com> <20190808000721.124691-20-matthewgarrett@google.com> <20190808111246.GA29211@linux-8ccs>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 8 Aug 2019, Jessica Yu wrote:

> > +#ifdef CONFIG_MODULES
> > +#define mod_name(mod) ((mod)->name)
> > +#else
> > +#define mod_name(mod) "unknown"
> > +#endif
> > +
> 
> Hm, I don't think mod_name is used anywhere?
> 
> But other than that:
> 
> Acked-by: Jessica Yu <jeyu@kernel.org>
> 

Matthew: no need to respin the patchset just for this. 

-- 
James Morris
<jmorris@namei.org>

