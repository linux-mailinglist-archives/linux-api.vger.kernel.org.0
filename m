Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE240C829
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhIOPW0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 11:22:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhIOPW0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 11:22:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B672F1F41DC1
Message-ID: <2f2cf258-24f4-8bbb-a33e-c92aafa22a9f@collabora.com>
Date:   Wed, 15 Sep 2021 12:20:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        mingo@redhat.com, tglx@linutronix.de, kernel@collabora.com,
        krisman@collabora.com, rostedt@goodmis.org,
        linux-api@vger.kernel.org, dvhart@infradead.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        dave@stgolabs.net, arnd@arndb.de
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20210915141525.621568509@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 11:07 de 15/09/21, Peter Zijlstra escreveu:
> From: André Almeida <andrealmeid@collabora.com>
> 
> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
> 
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
> 	    unsigned int flags, struct timespec *timo)
> 
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_s
>  #define __NR_process_mrelease 448
>  __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>  
> +#define __NR_futex_waitv 449
> +__SC_COMP(__NR_futex_waitv, sys_futex_waitv)
> +

Oops, this should be __SYSCALL(), and not __SC_COMP(), my bad.
