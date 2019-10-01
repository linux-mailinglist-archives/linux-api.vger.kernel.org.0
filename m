Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B129FC2BF0
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJACgU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 22:36:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfJACgU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 22:36:20 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iF81I-0005Zs-73; Tue, 01 Oct 2019 02:36:08 +0000
Date:   Tue, 1 Oct 2019 04:36:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] perf_event_open: switch to copy_struct_from_user()
Message-ID: <20191001023606.bkcji3tt6bgu6p5a@wittgenstein>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-5-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001011055.19283-5-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 11:10:55AM +1000, Aleksa Sarai wrote:
> The change is very straightforward, and helps unify the syscall
> interface for struct-from-userspace syscalls.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
