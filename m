Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5D409983
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhIMQkX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbhIMQkS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 12:40:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DACC061764
        for <linux-api@vger.kernel.org>; Mon, 13 Sep 2021 09:39:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z1so12921508ioh.7
        for <linux-api@vger.kernel.org>; Mon, 13 Sep 2021 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QgPmXhkOYWcDskB4kHZOp4vG0diXj/h4QVPXGAl64bo=;
        b=lYth0XvBIHWMPE+3uTwLezuvykWxoJCYCe5y5sBoWoCbiRi5kpNA8sc9UvqcaOlwwa
         zZhXSYtlGJLlb8OWWlK66kC0Fq9ZY+cEbq00CWOUEIYayBfEF62nSenTs9d5y60yQynT
         J18qnVl6TXP1RQTgB3LMTfzw0AgZeSIZIxnyOKJPvUbb7UHh2y/Nm+HHoYhkA2cEsCmK
         7pUr+pxEu870h5bm/VJnbi4LkbxnMH1e05J4AY9PZVGEfXDWkrjUQM+qsPLzlhgYKn9k
         PR55TU2ErL1q2s621azApGXnas7hMKqv19ZqOnr76KTXFON7kKa3qbxDH/LrQLDA8Mnf
         y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QgPmXhkOYWcDskB4kHZOp4vG0diXj/h4QVPXGAl64bo=;
        b=ZDi3q6tulryW3sRBMHvdjHknhtt+gAFG3/0muAG7xoWZho+V3lqo4Qzb68xTODzMtj
         v82HbwLMYjgZaGNCHbUZR6PvFioYg3ebE5oAjWcPY8b6vNEX24LDEmMlBiSOITGH0h9s
         DOGD6a02BLWWB1PiDJyyGI4qF4iYTC3I/PU4bj7NVWPglWKdLAvOkKwthNYEM0BEHO9f
         Eyk8BuRgM03ZULqgWLy4p0oziPOOxkKB7EAiSpy064FVZWdxYyT/qYFf6Ih+4pxISqRP
         iU/DCUp+N3CBp32OnLQ4SqhES7UDog9Zd2gPLbswnyehSdugRcadzz5/g7LT1z2qXnMZ
         Wz4Q==
X-Gm-Message-State: AOAM530Y/9Rm9NHCbHHkSYf5YZSjLRZmGkhHmc7905neHoZVl0bUi/iD
        aGESKmlpGgUK1X6v9rXmbUPJhZVrCfviCy3Lkxs=
X-Google-Smtp-Source: ABdhPJwIH46yMQrRfonY6727T9MHgQNlwt2v7sW0W15MmUyGo3M1vGiZdaYBQi9u+uTk/0WQ56dWIw==
X-Received: by 2002:a6b:3e89:: with SMTP id l131mr10002238ioa.74.1631551141125;
        Mon, 13 Sep 2021 09:39:01 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm4803710ioa.35.2021.09.13.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 09:39:00 -0700 (PDT)
Subject: Re: [PATCH v3] io-wq: provide IO_WQ_* constants for
 IORING_REGISTER_IOWQ_MAX_WORKERS arg items
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
References: <20210913154415.GA12890@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d808823-ac22-cd97-ed7a-bac638b3d3ed@kernel.dk>
Date:   Mon, 13 Sep 2021 10:38:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913154415.GA12890@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/13/21 9:44 AM, Eugene Syromiatnikov wrote:
> The items passed in the array pointed by the arg parameter
> of IORING_REGISTER_IOWQ_MAX_WORKERS io_uring_register operation
> carry certain semantics: they refer to different io-wq worker categories;
> provide IO_WQ_* constants in the UAPI, so these categories can be referenced
> in the user space code.

Applied, thanks.

-- 
Jens Axboe

