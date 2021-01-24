Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876FF301EB2
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXUXP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 15:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXUXO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 15:23:14 -0500
Received: from clue.drijf.net (clue.drijf.net [IPv6:2a02:898::216:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE88C06174A
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 12:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drijf.net; s=default;
        t=1611519746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vwjv4R2NO6n+x65BqIJbFbF4BI06IGFsIYzBvIg/kPA=;
        b=jqbF4zpM0lbpgwmzloee5Om2LKlK1cJ5NClcD8oxGLz9uOkEN8kpmW7Kbh7RXmBcjZwpgh
        eOh38RhbVSk7D6Qg9B2kunkYtwbdUhOgdFynS4gIfGx8rdmpX0ghnEzM++JYw9wDe++5bt
        Cm6Euhi8fygMXfkGDGkiyt3dbgCClKg=
Received: from clue.drijf.net (clue.drijf.net [94.142.244.34])
        by mx1.drijf.net (OpenSMTPD) with ESMTPSA id 3399abc6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 24 Jan 2021 21:22:26 +0100 (CET)
Date:   Sun, 24 Jan 2021 21:22:24 +0100
From:   Otto Moerbeek <otto@drijf.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Christian Groessler <chris@groessler.org>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org,
        Roman Czyborra <roman@czyborra.com>,
        Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
Message-ID: <YA3XAFLLeGiKyeLE@clue.drijf.net>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
 <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jan 24, 2021 at 01:01:45PM -0700, Alex Henrie wrote:

> On Sun, Jan 24, 2021 at 10:51 AM Otto Moerbeek <otto@drijf.net> wrote:
> >
> > Please stop pushing your diff to this list. So far nobody showed any
> > interest.
> 
> I am definitely interested. Bernhard Voelker seemed to express
> interest as well, conditional on -q being added to POSIX first.[1]
> Also, a --quiet flag was proposed back in 2001 by Roman Czyborra [2]
> and Jim Meyering expressed support for the idea.[3]
> 
> -Alex
> 
> [1] https://lists.gnu.org/archive/html/coreutils/2021-01/msg00043.html
> [2] https://lists.gnu.org/archive/html/bug-sh-utils/2001-05/msg00024.html
> [3] https://lists.gnu.org/archive/html/bug-sh-utils/2001-05/msg00039.html

"This list" is the OpenBSD tech list, sorry I did leave out this
context info.

	-Otto
