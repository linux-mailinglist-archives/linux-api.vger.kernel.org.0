Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667F51024B0
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 13:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfKSMly (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 07:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSMly (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 19 Nov 2019 07:41:54 -0500
Received: from localhost (unknown [89.205.136.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D351421D7B;
        Tue, 19 Nov 2019 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574167313;
        bh=jIhRA2VwaLRoYAsN0KyguVUzU+5d8qr8uraCIb163JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqZ15+AB9gEx214RhI/6BiIld+DI3r8SCSyl30Sf8k1vshnIZ2+FvimgC0q7d6HYr
         2oWTxdvy9cvWFmdKRLSP00W1sVGYzsuzMiAGtxi/P2qzcYTsjtownsUArlI4rB4Q6d
         CCIMBEXBglKack0f6GwI6WeQVE0krS4PINE+Ku8c=
Date:   Tue, 19 Nov 2019 13:41:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20191119124150.GB1975017@kroah.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de>
 <DDB907EA-3FCC-40C7-B55B-A84BC77FD7A1@amacapital.net>
 <3159012.PsEOTp9LqO@positron.chronox.de>
 <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 19, 2019 at 02:07:40AM -0800, Andy Lutomirski wrote:
> > As this would introduce a new device file now, is there a special process that
> > I need to follow or do I need to copy? Which major/minor number should I use?
> >
> > Looking into static const struct memdev devlist[] I see
> >
> >          [8] = { "random", 0666, &random_fops, 0 },
> >          [9] = { "urandom", 0666, &urandom_fops, 0 },
> >
> > Shall a true_random be added here with [10]?
> 
> I am not at all an expert on chardevs, but this sounds generally
> reasonable.  gregkh is probably the real authority here.

[10] is the aio char device node, so you better not try to overlap it or
bad things will happen :(

thanks,

greg k-h
