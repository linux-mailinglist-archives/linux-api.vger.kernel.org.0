Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD81052A8
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 14:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUNHW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 08:07:22 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:34844 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKUNHV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 08:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574341639;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lkH2kJJroo23f8ysnr6W6slIIL5c54hIxdLApd4rKcc=;
        b=LF9XC0Q1hlupOno6vPeKRb4fO7/GvKCi+JwuWcqX6ngoKX+9tjHUKtHP+LKUSO2hGH
        5m5r+RONviIfQBO8X9MXEO/IB2BU2tNkhziTmUMpcyMhfTU73xXuXdqpTUvuM41AKT7I
        MfyPq8dObJTawEn0VqJZL+hZVEYD+DPd3fOhdKm5U/UzXtvBSs5GoCvcdEuSRwrsCn+f
        gtQzO4MDUDs2e0uHmAGc4YhXhYP9qplJntR0oWWdvnoUr46d2a+aJSPMxRKiZTrib3/v
        3e8aePAjq+8qno8Zwy5kV7GcZLP7NBZUHANoNEVm79HPdM1QwnCdu9OkBEPQYOfsKcQg
        TFWQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXPSIvSWlTs="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vALD63rSB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 14:06:03 +0100 (CET)
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
Date:   Thu, 21 Nov 2019 14:06:03 +0100
Message-ID: <5032854.qLNvD48x4y@positron.chronox.de>
In-Reply-To: <20191120203232.GB3109949@kroah.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de> <1695782.oZ5Vf4nH9s@positron.chronox.de> <20191120203232.GB3109949@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Mittwoch, 20. November 2019, 21:32:32 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> No, do not abuse sysfs or procfs for something like this.  Use a real
> syscall please if you really need it.

You are right.

Ok, let us get back to the drawing board. What are our requirements? We need 
to have an interface for the TRNG that should ensure other users of entropy 
are not starved by unprivileged users.

What about the following: we use the getrandom(2) system call and add 
GRND_TRUERANDOM as already indicated. However, there is one more caveat we 
would add:

- if the caller of GRND_TRUERANDOM is !CAP_SYS_ADMIN the entropy pool can only 
be depleted to the point where at least one or two full seeding operations 
worth of entropy is left.

- if the caller of GRND_TRUERANDOM is CAP_SYS_ADMIN, the entropy can be 
depleted completely

At runtime, the LRNG would then behave like the following:

- calling getrandom(..., 0), /dev/random or /dev/urandom would deplete the 
entropy pool during reseeding operations but leaving an emergency level of 512 
bits of entropy in the pool. If equal or less are in the pool, reseeding would 
be skipped.

- calling getrandom(..., GRND_TRUERANDOM) with CAP_SYS_ADMIN allows the 
entropy pool to be fully depleted.

- calling getrandom(..., GRND_TRUERANDOM) without CAP_SYS_ADMIN allows the 
entropy pool to be depleted down to 1024 bits of entropy. If the pool has 
equal or less, the caller is blocked. This allows the DRNG feeding /dev/
random, /dev/urandom or getrandom(..., 0) with 512 bits of entropy (i.e. two 
reseed operations are possible). Only if the entropy pool has more than 1024 
bits of entropy, the getrandom call would unblock and provide data.

With that approach, I think we can honor the request from Greg to not add any 
new interface and yet honor the note from Alexander to not allow unprivileged 
user space to deplete the entropy pool to the extent that other users of 
entropy are too much affected.

If GRND_TRUERANDOM is not implemented, EOPNOTSUPP is returned.

Thank you.

Ciao
Stephan


