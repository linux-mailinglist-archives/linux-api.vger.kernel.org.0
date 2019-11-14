Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D02FC650
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKNM3b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 07:29:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNM3b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 07:29:31 -0500
Received: from [79.140.120.64] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVEFX-0001o2-F2; Thu, 14 Nov 2019 12:29:23 +0000
Date:   Thu, 14 Nov 2019 13:29:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jann Horn <jannh@google.com>, Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <20191114122921.37faj6e4blsclx6g@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
 <090860a8-e57f-d4ea-88d4-086ea32e37d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <090860a8-e57f-d4ea-88d4-086ea32e37d9@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 14, 2019 at 01:15:58PM +0100, Michael Kerrisk (man-pages) wrote:
> I've fixed the example code in the manual page to use
> mmap(MAP_STACK), rather than malloc(), to allocate the stack.

Thank you!
Christian
