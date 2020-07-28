Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625D623141A
	for <lists+linux-api@lfdr.de>; Tue, 28 Jul 2020 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgG1Ukr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jul 2020 16:40:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50042 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgG1Ukr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Jul 2020 16:40:47 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3489E1C0BED; Tue, 28 Jul 2020 22:40:45 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:40:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephan M?ller <smueller@chronox.de>
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
Subject: Re: [PATCH v31 00/12] /dev/random - a new approach with full
 SP800-90B
Message-ID: <20200728204044.GD1012@bug>
References: <2050754.Mh6RI2rZIc@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2050754.Mh6RI2rZIc@positron.chronox.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!

> The following patch set provides a different approach to /dev/random which is called 
> Linux Random Number Generator (LRNG) to collect entropy within the Linux kernel. The 
> main improvements compared to the existing /dev/random is to provide sufficient entropy 
> during boot time as well as in virtual environments and when using SSDs. A secondary 
> design goal is to limit the impact of the entropy collection on massive parallel systems 
> and also allow the use accelerated cryptographic primitives. Also, all steps of the 
> entropic data processing are testable.

That sounds good.. maybe too good. Where does LRNG get the entropy? That is the
part that should be carefully documented..

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
