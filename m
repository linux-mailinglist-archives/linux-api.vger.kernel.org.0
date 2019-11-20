Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E21104524
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 21:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTUcg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 15:32:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKTUcg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 20 Nov 2019 15:32:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33AC20872;
        Wed, 20 Nov 2019 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574281955;
        bh=rgz7tSc56R6AlFhUwHCm3gukAfl1sHXelnLXuoyn9n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxytrLSujkMi+YhB60vQ4R5qA6bi7jIjXFJCPx0aj6ZCR2dKlKjWHI649X9tToNSd
         5u+a+9w4YBtS9AcvywmrIMwG5XV6XwGzKwtDkp4YuWzFG2LES9dsOJYsGMthUe/NhI
         a2QS8rjcGaeNUNn8GJwOHx5qfXXsS8WeLJrXdWKE=
Date:   Wed, 20 Nov 2019 21:32:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
Message-ID: <20191120203232.GB3109949@kroah.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de>
 <19681012.svDddlc5pN@positron.chronox.de>
 <20191120132918.GA2892197@kroah.com>
 <1695782.oZ5Vf4nH9s@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1695782.oZ5Vf4nH9s@positron.chronox.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 20, 2019 at 08:51:11PM +0100, Stephan Müller wrote:
> Am Mittwoch, 20. November 2019, 14:29:18 CET schrieb Greg Kroah-Hartman:
> 
> Hi Greg,
> 
> > On Wed, Nov 20, 2019 at 09:58:35AM +0100, Stephan Müller wrote:
> > > Am Dienstag, 19. November 2019, 13:41:50 CET schrieb Greg Kroah-Hartman:
> > > 
> > > Hi Greg,
> > > 
> > > > On Tue, Nov 19, 2019 at 02:07:40AM -0800, Andy Lutomirski wrote:
> > > > > > As this would introduce a new device file now, is there a special
> > > > > > process that I need to follow or do I need to copy? Which
> > > > > > major/minor
> > > > > > number should I use?
> > > > > > 
> > > > > > Looking into static const struct memdev devlist[] I see
> > > > > > 
> > > > > >          [8] = { "random", 0666, &random_fops, 0 },
> > > > > >          [9] = { "urandom", 0666, &urandom_fops, 0 },
> > > > > > 
> > > > > > Shall a true_random be added here with [10]?
> > > > > 
> > > > > I am not at all an expert on chardevs, but this sounds generally
> > > > > reasonable.  gregkh is probably the real authority here.
> > > > 
> > > > [10] is the aio char device node, so you better not try to overlap it or
> > > > bad things will happen :(
> > > 
> > > Thanks for your insights.
> > > 
> > > Which device minor number could we use?
> > 
> > Get your own dynamic one by using a misc device if you _REALLY_ want to
> > add yet-another-char-node-for-random-data.
> > 
> > But I would have thought that we all realize that this is not the way to
> > do things.  Let's not have "random", "urandom", and "true_random" be
> > something we want to totally confuse userspace with, that way is insane.
> > 
> > Please just make the existing userspace api "just work", don't add to
> > the mess.
> 
> Thank you, I think we should follow that advise.
> 
> With that and considering Alexander's rightful remark we have a challenge. So, 
> changing the syscall may not be the right way unless we find a way to restrict 
> the permissions somehow (capability? LSM? None of that seems to be a good 
> fit).
> 
> What about providing a /sys file? I.e. adding a file that:
> 
> a) has permissions 440 per default and maybe the ownership of root:root
> 
> b) allow user space to perform a chown/chgrp
> 
> c) only supports reading of data from user space
> 
> But then, how could we provide a common interface for the existing random.c 
> and the LRNG?
> 
> Or should we use a proc file for that? If yes, I guess it should not be a 
> sysctl, but a "regular" proc file that should allow a chown(2) operation. On 
> the other hand, is proc the right place to provide a user space interface for 
> exporting data to user?

No, do not abuse sysfs or procfs for something like this.  Use a real
syscall please if you really need it.

greg k-h
