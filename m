Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20914562B9
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhKRSqF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 13:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhKRSqF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 13:46:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6232C061574
        for <linux-api@vger.kernel.org>; Thu, 18 Nov 2021 10:43:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x7so5891517pjn.0
        for <linux-api@vger.kernel.org>; Thu, 18 Nov 2021 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIfTaK8YNJkvwlhWs/R7+lUHr+UlSTFkv+/+qJc6Tuo=;
        b=ptxnmorXLNeEci5P4pYiiWMEUa/TGS1AMXsxvRHisiMnFXF46LfYTA0Y8g7n8sl14Q
         cd5B6Lg6ruIPSB+u3lC8nPsF0SXwk8vQzsNQfrpkxHqrN9/UJrZ7x0kK2uaekr7Rd5ED
         F0IEE/+9NrSIIiuZCQLdV6MC2n8Hxnj/eMf79XjpfDs67474EEdiGANR/wndOu8fGDOk
         0XCB0+xEvP5FYPWwzAPsfchI4XCiiZcV81LJBXjlQQmi5WvaNQXnBGqjb4NBL8FmHr3v
         FDIT0LWlN9Udd1lDtUxyv6HOuh/uSwWRgLMbzmDEdQ+q3RZxILFZyeb4e39I6twnp/Vp
         KmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIfTaK8YNJkvwlhWs/R7+lUHr+UlSTFkv+/+qJc6Tuo=;
        b=WC3M24x1OL5uwufFE5axy4eC9F1CVzWRMMYMVOCdF6VCIKcMOkoD8sCW+GKjFZCsaG
         KftFaarQuTxBZ+V+TLzf3zYSGq4vuELJTjTm+UcRsQhxRf2pQfhg3DDVFLzk3Xa9myEO
         WijdGENswhiL6f1Hs6HMwZlHDsJWiCdVZnf82fBV4xX1au5yqnvDXC7rKwlf0a0YQ0OD
         xk1deqGuspV4yHVTFXMrDbcqSpsAZWEMw73WjpCEOZYX3t5pDyL7mpoufAAQZuWfRXf/
         ssGjzi7NQSfk608lU1VD5JHrWFVWIgqtANMw5dexbU4IQNdEHbQogR/d1SrdaQeG1YyY
         XRcQ==
X-Gm-Message-State: AOAM533zNwVknYCScH0K+YDLNpZWClWwS43WFpGFHoe7AoP7W9MVaouK
        A7jkZlPAErort/YfbV3ZPL/dvcejGJ1Nr7FR2zs=
X-Google-Smtp-Source: ABdhPJxl3jTHQ1zrj3LhrgNMght/pfDQrQCW9OQv89UzvIIW7rDg3bxvZ53HkAkTz+4g+artoX2/xl/t8kQIfKCuopE=
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id
 j5-20020a170902690500b001429e19702emr70209395plk.34.1637260984488; Thu, 18
 Nov 2021 10:43:04 -0800 (PST)
MIME-Version: 1.0
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 18 Nov 2021 12:42:53 -0600
Message-ID: <CAFUsyfKGOCk9vhWTsfP2tH1-P=iYe41vCxbUdfx-b3Oa9ma7iw@mail.gmail.com>
Subject: Re: Bringing rseq back into glibc
To:     Florian Weimer <fweimer@redhat.com>
Cc:     GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 18, 2021 at 4:17 AM Florian Weimer via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> I would like to bring back rseq for glibc 2.35.  I propose the following
> steps:
>
> 1. Enable rseq registration in glibc, for internal use only.  This time,
>    put the rseq area into struct pthread, not into a initial-exec TLS
>    symbol.  (This helps to avoid with initial-exec TLS bloat with dlopen
>    and simplifies initialization somewhat.)

Isn't THREAD_SELF also implemented in TLS? Or am I missing
something?

>
> 2. Add a tunable to disable rseq registration in glibc.  This way, if
>    there is already an rseq user, it can be made to work again by
>    setting the tunable.
>
> 3. Implement sched_getcpu on top of rseq.
>
> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>    or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>    offset to add to the thread pointer (see __builtin_thread_pointer) to
>    get to the rseq area.  They will be public ABI symbols.  These
>    variables are initialized before user code runs, and changing the
>    results in undefined behavior.
>
> Under this model, the rseq area offset is clearly constant across all
> threads.  (This was previously implied by using initial-exec TLS
> memory.)  rseq registration failure is indicated by __rseq_abi_size ==
> 0.  If the size is non-zero, rseq will be registered on all threads
> created by glibc, and all the time as far as user code is concernes.
> (This assumes that if rseq registration succeeds on the main thread, it
> will succeed on all other threads.  We will terminate the process if
> not.)  For example, if a JIT compiler sees __rseq_abi_size >= 32, in
> generated code, it can inline a version of sched_getcpu that
> materializes the thread pointer and loads the cpu_id field from the rseq
> area, without further checks.  Under the old TLS-based model, it was
> less clear that this was a valid optimization.
>
> Furthermore, I believe this approach will be more compatible with
> potential future kernel changes in this area.  If the kernel tells us
> some day through the auxiliary vector that we should register a 128-byte
> rseq area with 64-byte alignment, we can make that happen and change
> __rseq_abi_offset and __rseq_abi_size accordingly.
>
> Steps 1 to 3 are backportable to previous glibc version, especially to
> 2.34 with its integrated libpthread.
>
> Comments?  As I said, I'd like to bring these changes into glibc 2.35,
> hopefully in early December.
>
> Thanks,
> Florian
>
