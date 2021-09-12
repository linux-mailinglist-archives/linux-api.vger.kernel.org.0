Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1A407F6A
	for <lists+linux-api@lfdr.de>; Sun, 12 Sep 2021 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhILSa6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 Sep 2021 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhILSa6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 Sep 2021 14:30:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84B2C061760
        for <linux-api@vger.kernel.org>; Sun, 12 Sep 2021 11:29:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y18so9225574ioc.1
        for <linux-api@vger.kernel.org>; Sun, 12 Sep 2021 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rarLVmhjlYCLBQP/dFIghpuLAWbLj88vP6T0e8keIE=;
        b=hLJBZhwubj3JFpf6gdUSuPJmM5Xmwh7RET4YKzt2SytNGLpRpOJ14lAHyDpi6j4WqQ
         tjBdsWafGKD1e5q5YmgdAYMJhQmein+qYM41GAeATMBt4Erj9jK5vRcswwWsRCdgA1Zw
         o/VEPFpZW119IBYPwQ8G4aYDv9rsY3mSYhA2bKMlBjCfBbTo0aywG+NwqCL7QFktudtr
         cNx3b+ewrzljtTpzD3veBLObjp2FNGcqrq2sQyGOdwHxG68yutrkclk06Rg20cVRroD3
         jY8jL0yXSs0aYVUDPUeAdJrARHPKRGEaKYZLdPtSOdRgAq+R9KR6iJ8ZrEaeIq7uGoGc
         Exrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rarLVmhjlYCLBQP/dFIghpuLAWbLj88vP6T0e8keIE=;
        b=AnBmxCaS5DGWL/kMjvz6nkr9bu+E2SfhD5c3MUrceEXmm1cyWPZ8RAicGwG7J4aGik
         6Z0+0ZmREkSPAFdfZ0HNpuzbj4RhT/kUkkhlwVnV8f1gZq8nA69zDSi8O5RhYSRk3D3J
         og9kim724VsNHSep85hFjp/ePgLh04fGF0IbZW/92Su8pGhviLeS20W+QXc6Pvfhc9YF
         6b9uLt8wYtref8lE1dj+RxXhRHJoiAJfKHb+GestEwpmXFw3xE0g7IHPnjW7s84dY4Zn
         1j4z00vUwsnjggdZMG3me+OQ2pH+cQe72AtzAfkMtcciD7oSdLbd0E4ZgAqbgS/QZyIH
         vNFw==
X-Gm-Message-State: AOAM533FE01yFjIWXcegDDVuMwN0GeDo5AusUA7kwaW3kdxowg1gsPML
        he+7DzaYvFYIOHoqgdo9A2XK+1VnZ0+19w==
X-Google-Smtp-Source: ABdhPJwVwJgSLhPe0+BW+Sq74zac2nHWb5SRB41ZT3wL3Lu6eSg64DEbxo3/P7URMgWaWB9IesOyjg==
X-Received: by 2002:a5e:990e:: with SMTP id t14mr6060888ioj.75.1631471382926;
        Sun, 12 Sep 2021 11:29:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b8sm3212270ilc.41.2021.09.12.11.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 11:29:42 -0700 (PDT)
Subject: Re: [PATCH] io-wq: expose IO_WQ_ACCT_* enumeration items to UAPI
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
References: <20210912122411.GA27679@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6027db7-3ebc-6f12-2b58-4b068a346ee2@kernel.dk>
Date:   Sun, 12 Sep 2021 12:29:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210912122411.GA27679@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/12/21 6:24 AM, Eugene Syromiatnikov wrote:
> These are used to index aargument of IORING_REGISTER_IOWQ_MAX_WORKERS
> io_uring_register command, so they are to be exposed in UAPI.

Not sure that's necessary, as it's really just a boolean values - is
the worker type bounded or not. That said, not against making it
available for userspace, but definitely not IO_WQ_ACCT_NR. It
should probably just go in liburing, I guess.

-- 
Jens Axboe

