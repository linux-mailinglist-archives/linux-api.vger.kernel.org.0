Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DA231A2D
	for <lists+linux-api@lfdr.de>; Wed, 29 Jul 2020 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgG2HRO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jul 2020 03:17:14 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:18796 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgG2HRN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jul 2020 03:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596007027;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sdhs3yS8aMc4aowa6IxLuB0eXJ97dxSTuJg2++WqobQ=;
        b=OyPRLcFDNnoth0RGD+/DE6IPhruJ8IST7NNMkmwxOc7CoTrXtBrGFE6CSoK4Q/y4wc
        QFiXbYnXOxLUpIbIHqbOhb/Ktg5syXF8C9Cb1k2fpWWQH7FpqjZtK52zSXIhD9YW16Bb
        +4zOHa00RlgTQP9uxwGQNU6tWIVUNZmqsidm34+mhIOFfEQvV1+01zURmstiK7YEszl4
        pcFp+wZBQjUnCk5y75g9DUWD4lxeXnzfrjLNPLxY50xknQogjgvCnhSu4lbheiGV66bV
        OWkD86Oe5Rfx+60We1s/BMxyNgtZ8IMwFJ8VAe8V51UjWS3j8yjLcLS17F8tr8O4OxHX
        dxmg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbLvSf24qr"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id y0546bw6T7FgBYj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 29 Jul 2020 09:15:42 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
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
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v31 00/12] /dev/random - a new approach with full SP800-90B
Date:   Wed, 29 Jul 2020 09:15:42 +0200
Message-ID: <2739109.8hzESeGDPO@tauon.chronox.de>
In-Reply-To: <20200728204044.GD1012@bug>
References: <2050754.Mh6RI2rZIc@positron.chronox.de> <20200728204044.GD1012@bug>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 28. Juli 2020, 22:40:44 CEST schrieb Pavel Machek:

Hi Pavel,

> Hi!
> 
> > The following patch set provides a different approach to /dev/random which
> > is called Linux Random Number Generator (LRNG) to collect entropy within
> > the Linux kernel. The main improvements compared to the existing
> > /dev/random is to provide sufficient entropy during boot time as well as
> > in virtual environments and when using SSDs. A secondary design goal is
> > to limit the impact of the entropy collection on massive parallel systems
> > and also allow the use accelerated cryptographic primitives. Also, all
> > steps of the entropic data processing are testable.
> 
> That sounds good.. maybe too good. Where does LRNG get the entropy? That is
> the part that should be carefully documented..
> 
> 									Pavel

The entire description of the LRNG is given in [1].

[1] section 2.1 outlines the general architecture specifying that there are 
currently 3 noise sources. Per default, the interrupt-based noise source is 
the main source.

Section 2.4 outlines the details of the interrupt noise source handling. The 
key now is unlike the existing implementation that there is no separate block/
HID noise collection because they are "just" derivatives of the interrupt 
noise source which would imply that noise events are double credited with 
entropy. This allows for a massively higher valuation of the entropy rate that 
exists in interrupt events.

To support the design, a large scale noise source analysis is performed in 
chapter 3 [1]. Specifically sections 3.2.3 and 3.2.4 provide quantitative 
statements which are further analyzed in subsequent sections. This includes 
reboot tests as well as runtime tests.

[1] appendix C performs these measurements on other CPU architectures, 
including very small environments which could be expected to have too little 
entropy (specifically the first listed ARM system mentioned there and the MIPS 
system are older embedded devices that yet show sufficient entropy). Also, the 
entropy available in virtual environments is shown in appendix C.

The tools perform the aforementioned measurements are provided with the 
enabling of CONFIG_LRNG_RAW_ENTROPY supported by [2]. This allows everybody to 
re-perform the analysis on the system of his choice.

Also, the entire entropy assessment of the LRNG is supported by the entropy 
analysis of the existing implementation in [3]. Specifically section 6.1 shows 
that the existing implementation has much more entropy available in the 
interrupt events than it credits. Yet, due to the design of the existing 
implementation with the fast pool (for which we have no assessment how much 
entropy is lost by it) and the fact of double counting of entropy with HID/
block devices, the massive underestimation of existing entropy with the 
existing /dev/random implementation is warranted.

Lastly, [4] performs the entropy assessment of the existing /dev/random 
implementation in virtualized environments showing that still sufficient 
entropy is available in interrupt events supporting the approach taken in the 
LRNG. Writing the assessment of [4] was the initial trigger point for me to 
start the LRNG implementation.

The second noise source that, however, is credited much less entropy is 
documented in [5] including its entropy assessment.

[1] https://chronox.de/lrng/doc/lrng.pdf

[2] https://chronox.de/lrng/lrng-tests-20200415.tar.xz

[3] https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/
LinuxRNG/LinuxRNG_EN.pdf?__blob=publicationFile

[4] https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/Studien/
ZufallinVMS/Randomness-in-VMs.pdf?__blob=publicationFile

[5] https://chronox.de/jent/doc/CPU-Jitter-NPTRNG.pdf

Ciao
Stephan


