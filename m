Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F108140CC84
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhIOSZ6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIOSZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 14:25:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDFC061574;
        Wed, 15 Sep 2021 11:24:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9E3501F41F5A
Message-ID: <f6b5514d-9ad8-59ae-6a86-c9fe5eb81895@collabora.com>
Date:   Wed, 15 Sep 2021 15:24:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 00/20] futex: splitup and waitv syscall
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        dave@stgolabs.net, arnd@arndb.de, dvhart@infradead.org
References: <20210915140710.596174479@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20210915140710.596174479@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 11:07 de 15/09/21, Peter Zijlstra escreveu:
> Hi,
> 
> Neither Thomas nor myself much liked that futex2.c nor do we think that CONFIG_
> symbol makes much sense.
> 
> However, futex.c is a wee bit long and splitting it up makes sense. So I've
> taken the liberty to replace your initial patch with 15 of my own and then
> rebased the remaining patches on top of that.
> 
> Thomas, does something like this work for you?
> 
I tested this patchset:

- On top of a full distro
- Using futex kselftests
- Running glibc's nptl tests, all 387 passed

It seems that things are working as expected. You can add my

	Reviewed-by: André Almeida <andrealmeid@collabora.com>

for patches 01 - 15.
