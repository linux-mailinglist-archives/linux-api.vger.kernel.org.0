Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC11333A5
	for <lists+linux-api@lfdr.de>; Tue,  7 Jan 2020 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgAGVUO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jan 2020 16:20:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36466 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728167AbgAGVEh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jan 2020 16:04:37 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007L3U6Q024697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:03:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4E9094207DF; Tue,  7 Jan 2020 16:03:30 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:03:30 -0500
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
Subject: Re: [PATCH v3 6/8] random: Remove the blocking pool
Message-ID: <20200107210330.GK3619@mit.edu>
References: <cover.1577088521.git.luto@kernel.org>
 <511225a224bf0a291149d3c0b8b45393cd03ab96.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511225a224bf0a291149d3c0b8b45393cd03ab96.1577088521.git.luto@kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 23, 2019 at 12:20:49AM -0800, Andy Lutomirski wrote:
> There is no longer any interface to read data from the blocking
> pool, so remove it.
> 
> This enables quite a bit of code deletion, much of which will be
> done in subsequent patches.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied, thanks.

					- Ted
