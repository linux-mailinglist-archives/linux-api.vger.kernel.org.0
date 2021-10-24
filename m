Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F584387F5
	for <lists+linux-api@lfdr.de>; Sun, 24 Oct 2021 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhJXJko (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Oct 2021 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJko (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Oct 2021 05:40:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E53C061764;
        Sun, 24 Oct 2021 02:38:23 -0700 (PDT)
Date:   Sun, 24 Oct 2021 11:38:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635068301; bh=jjiMz4s+JGUKKGZyYM9FJJ4O/T2nnh2DazSM6/l44Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDbfTU8QzWVk8K4ZJNHDRU3HlixRoKfsAxgakH+mhIM40hZ3fcQIKaujVuB06c08H
         lQaxuWqEwXgaW3HM6bwz5ihNaxjvnHMkrwDUHGb1Nxam3jYY3BHFNljt5iQOe58Jsc
         JAlckLcSmwPObtLVp9hyMqtoJCqxh5QleMkMazoU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <97e88a06-4dfc-485c-b562-bed2a8e4b1b8@t-8ch.de>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-09-19 09:56+0200, Thomas Weißschuh wrote:
> On 2021-09-18T11:47-0700, Andy Lutomirski wrote:
> > But I admit I’m a bit confused.  What exactly is the container doing that causes the container’s copy of modprobe to be called?
> 
> The container is running an instance of the docker daemon in swarm mode.
> That needs the "ip_vs" module (amongst others) and explicitly tries to load it
> via modprobe.

If somebody stumbles upon this specific issue:
The "ip_vs" module will be autoloaded in future kernel versions with
https://lore.kernel.org/lkml/20211021130255.4177-1-linux@weissschuh.net/
applied.

> > > If so the seccomp notifier can be used to intercept this system call for
> > > the container and verify the module against an allowlist similar to how
> > > we currently handle mount.
> > > 
> > > Christian
