Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA004103644
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 10:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfKTJAK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 04:00:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:21320 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfKTJAK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 04:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574240408;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FO60nC3S+oDIpCbZRvJjF5XfVNeQtlqMONqUWv0+n+4=;
        b=WHD6KRcpmfGt41cmracVFI7LHG2nA6QOu3C+28vmgLw3T/XxqCT3xmZntU3rx60nqT
        eP4dyq4w/MyBt3YYmVnpx1TUsq9s6WhTsy96GisjhqF2hzam+YztM3Ac8oVAn63NTuEG
        lJHd3pajGXUZA6Bp34W5+5dR1q8WzGyiDVix3r6tXNR5DjeXtWWvcflmRfIZy6zqz0Yt
        uwEsx4pZNUp8Rc5bEdMZVH1YuOY3o9w2kFOHcbtNRpmKECk2afF4RnYvwmxGHONEMjrq
        Stx3hZqPbAsHp7qG8q8DYWrXB+fETzKzLcP5Fim6wn/dQAAIofSODr4350yaxzv39lTw
        Nl5g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbL/ScbtM="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAK8wajR4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 09:58:36 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Date:   Wed, 20 Nov 2019 09:58:35 +0100
Message-ID: <19681012.svDddlc5pN@positron.chronox.de>
In-Reply-To: <20191119124150.GB1975017@kroah.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de> <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com> <20191119124150.GB1975017@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 19. November 2019, 13:41:50 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> On Tue, Nov 19, 2019 at 02:07:40AM -0800, Andy Lutomirski wrote:
> > > As this would introduce a new device file now, is there a special
> > > process that I need to follow or do I need to copy? Which major/minor
> > > number should I use?
> > > 
> > > Looking into static const struct memdev devlist[] I see
> > > 
> > >          [8] = { "random", 0666, &random_fops, 0 },
> > >          [9] = { "urandom", 0666, &urandom_fops, 0 },
> > > 
> > > Shall a true_random be added here with [10]?
> > 
> > I am not at all an expert on chardevs, but this sounds generally
> > reasonable.  gregkh is probably the real authority here.
> 
> [10] is the aio char device node, so you better not try to overlap it or
> bad things will happen :(

Thanks for your insights.

Which device minor number could we use?

Or another idea and apologies if I restart this conversation as there was 
already a discussion around it: what about extending the getrandom(2) call 
instead of adding a device file?

What about adding yet another flag to getrandom: GRND_TRUERANDOM and process 
it as follows:

        if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE|
GRND_TRUERANDOM))
                return -EINVAL;

        //From Andy's tree
        /*
         * Requesting insecure and blocking randomness at the same time makes
         * no sense.
         */
        if ((flags & (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|
GRND_RANDOM))
                return -EINVAL;

	  /* We only allow GRND_TRUERANDOM by itself or with NONBLOCK */
	  if (! ((flags & GRND_TRUERANDOM) &&
               ((flags == GRND_TRUERANDOM) ||
                (flags == GRND_TRUERANDOM | GRND_NONBLOCK))))
		return -EINVAL;

	if (flags & GRND_TRUERANDOM) {
		... do the TRNG processing ...
		... may return -ENOPNOTSUPP if no TRNG available ...
	}

Thanks a lot.


Ciao
Stephan


