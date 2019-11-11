Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB44CF794E
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKKQ6Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 11:58:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39040 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727027AbfKKQ6Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 11:58:25 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xABGw1ir031439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 11:58:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C0DC94202FD; Mon, 11 Nov 2019 11:58:00 -0500 (EST)
Date:   Mon, 11 Nov 2019 11:58:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jann Horn <jannh@google.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <20191111165800.GD7017@mit.edu>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 11, 2019 at 03:55:35PM +0100, Jann Horn wrote:
> Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
> was announced here:
> <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
> Basically they periodically check whether the userspace stack pointer
> points into a MAP_STACK region, and if not, they kill the process. So
> even if it's a no-op on Linux...

Hmm, is that something we should do in Linux?  Even if we only check
on syscall entry, which should be pretty inexpensive, it seems like it
would be very effective in protecting various ROP techniques.

      	      		   	      	      - Ted
