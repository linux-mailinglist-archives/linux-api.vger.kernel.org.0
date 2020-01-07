Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9C1331D1
	for <lists+linux-api@lfdr.de>; Tue,  7 Jan 2020 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAGVEN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jan 2020 16:04:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36392 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728799AbgAGVEL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jan 2020 16:04:11 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007L2vFj024569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:02:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 67AA74207DF; Tue,  7 Jan 2020 16:02:57 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:02:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v3 5/8] random: Make /dev/random be almost like
 /dev/urandom
Message-ID: <20200107210257.GJ3619@mit.edu>
References: <cover.1577088521.git.luto@kernel.org>
 <5e6ac8831c6cf2e56a7a4b39616d1732b2bdd06c.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6ac8831c6cf2e56a7a4b39616d1732b2bdd06c.1577088521.git.luto@kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 23, 2019 at 12:20:48AM -0800, Andy Lutomirski wrote:
> This patch changes the read semantics of /dev/random to be the same
> as /dev/urandom except that reads will block until the CRNG is
> ready.
> 
> None of the cleanups that this enables have been done yet.  As a
> result, this gives a warning about an unused function.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied, thanks.

						- Ted
