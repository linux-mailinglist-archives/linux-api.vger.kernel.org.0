Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD840A424
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhINDJO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbhINDJO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 23:09:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054FC061574;
        Mon, 13 Sep 2021 20:07:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 435611F427B0
Message-ID: <2b1541c3-6fcf-910c-5a25-1900bdbc87ca@collabora.com>
Date:   Tue, 14 Sep 2021 00:07:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 0/6] futex2: Add wait on multiple futexes syscall
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210913175249.81074-1-andrealmeid@collabora.com>
 <871r5sge5j.fsf@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <871r5sge5j.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 22:05 de 13/09/21, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@collabora.com> writes:
> 
>> Hi,
>>
>> This patchset introduce the futex_waitv syscall. It reuses as much as
>> possible of original futex code for the new operation, so the first
>> commit move some stuff to futex header to make accessible for futex2.
>>
> 
> In general, this series is missing a Documentation/ patch at the end.
> In particular since it adds a new interface.  Much of what you describe
> in the cover letter should go there...
> 

Ops, it seems that I forgot that commit behind, I'll add it for v4:
https://lore.kernel.org/lkml/20210805190405.59110-5-andrealmeid@collabora.com/

Thanks!
