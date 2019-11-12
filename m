Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A188F908E
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKLNXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 12 Nov 2019 08:23:22 -0500
Received: from albireo.enyo.de ([37.24.231.21]:42750 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfKLNXW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 12 Nov 2019 08:23:22 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iUW8U-0005If-Jp; Tue, 12 Nov 2019 13:23:10 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iUW8U-0002Cz-BA; Tue, 12 Nov 2019 14:23:10 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
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
        "Peter\, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v24 00/12] /dev/random - a new approach with full SP800-90B compliance
References: <6157374.ptSnyUpaCn@positron.chronox.de>
Date:   Tue, 12 Nov 2019 14:23:10 +0100
In-Reply-To: <6157374.ptSnyUpaCn@positron.chronox.de> ("Stephan
 \=\?iso-8859-1\?Q\?M\=FCller\=22's\?\=
        message of "Mon, 11 Nov 2019 19:17:30 +0100")
Message-ID: <875zjpfcu9.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Stephan Müller:

> * support deactivation of TRNG (i.e. blocking behavior of /dev/random)
>   at compile time. If deactivated, /dev/random behaves like
>   getrandom(2).

I don't quite understand this comment.  Doesn't getrandom with the
GRND_RANDOM always behave like /dev/random?  Presumably, without the
TRNG tap, the GRND_RANDOM flag for getrandom is ignored, and reading
from /dev/random behaves like reading from /dev/urandom.

Anyway, reading the accompanying PDF, this looks rather impressive:
the userspace bootstrapping problem is gone (the issue where waiting
for more entropy prevents the collection of more entropy), *and* we
can still make the standards people happy.

(Replying from my other account due to mail issues, sorry.)
