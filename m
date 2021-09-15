Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91B40C811
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhIOPSu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhIOPSt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 11:18:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348FC061574;
        Wed, 15 Sep 2021 08:17:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 252DD1F41CF6
Message-ID: <b1242a18-8f72-9005-1630-3a45297e95b5@collabora.com>
Date:   Wed, 15 Sep 2021 12:17:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 07/20] futex: Rename hash_futex()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        kernel@collabora.com, krisman@collabora.com, dvhart@infradead.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
References: <20210915140710.596174479@infradead.org>
 <20210915141525.047819744@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20210915141525.047819744@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 11:07 de 15/09/21, Peter Zijlstra escreveu:
> In order to prepare introducing these symbols into the global
> namespace; rename:
> 
>   s/hash_futex/hash_futex/g
> 

I think you meant

   s/hash_futex/futex_hash/g
