Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FA105635
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKUP40 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 10:56:26 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42979 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKUP4S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 10:56:18 -0500
Received: by mail-il1-f194.google.com with SMTP id n18so3732471ilt.9
        for <linux-api@vger.kernel.org>; Thu, 21 Nov 2019 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=p9f61F2qEE4/QwqhzVpQxRpsxX+tV3SxRebeynsmRfBNHvoMnRcPAeQBMJ4vetLpDz
         shfSAjNsSLR8/AyOjsQjN2cfgMUQmKjudar8cuqkQT4utDF/Fg0xyKUILGxfQL2m4ykC
         v2dKDPfCeTVXelv8ErH8wWKv+orr2ysEDzISJsEE+qs4wfsyfactwDmLH8MnBWJzVSmY
         XCTDegH0huTSluHvW6LcnV5C2iycu99pwuw2Q/YxucMfTo227eo59/I8ZMNVpzMswrI3
         2Efr4431bVIGY+4pWPJ+b3TiJoIazJewBg9vmPs5YlVPxg8N869vnJ+tezxnZ3CO4XTi
         5d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=uBJ2IqntgtQVGmOkhZtgOUfoBrmaz5kiX0wDqrI6Oulz86zXSiUE9UkKtuPAPKzMa1
         1qv/f+PpkS35w7exKgn+46egu7gTrQbF2gj1IzDd5bqDKl6nwat4UlHFMccc3JvlAzUh
         SCeBY2gx20FRIY6NIotNvadiCfLJQw+FeYe8LHcR3oNjK6Bec2jVDTbd/Z/0M8CdKuYx
         +a7N0Jo5bgZX93h+A9wORsWicU2RmAm4nEaUpM86w3hKfD3bHGtRCTiXcXoqc3iONnww
         ivzRnNi8N0kKBOA1rPy6KhrYivq7bqA8MtWDpiZtsnJwe7mFVSidw+kJcbXwL0B+sVUQ
         ditg==
X-Gm-Message-State: APjAAAXrBle08Nzx1UNjEjaKrjDDBZ/g70OVMS4TlL0iWXphZRSpaqE5
        7JPx4+8qf7hdYHHkgXdcy4w6Uw==
X-Google-Smtp-Source: APXvYqyBx1nTqGMRn9GsWSj0/giOcMCoKn/OjZ4stbz+xyyRba03IeYJrruyiFFcHRXe1jGKDNx4oA==
X-Received: by 2002:a05:6e02:100b:: with SMTP id n11mr10655778ilj.212.1574351776819;
        Thu, 21 Nov 2019 07:56:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 133sm1342001ila.25.2019.11.21.07.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:56:15 -0800 (PST)
Subject: Re: [PATCH] block: add iostat counters for flush requests
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
Date:   Thu, 21 Nov 2019 08:56:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157433282607.7928.5202409984272248322.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
> Requests that triggers flushing volatile writeback cache to disk (barriers)
> have significant effect to overall performance.
> 
> Block layer has sophisticated engine for combining several flush requests
> into one. But there is no statistics for actual flushes executed by disk.
> Requests which trigger flushes usually are barriers - zero-size writes.
> 
> This patch adds two iostat counters into /sys/class/block/$dev/stat and
> /proc/diskstats - count of completed flush requests and their total time.

This makes sense to me, and the "recent" discard addition already proved
that we're fine extending with more fields. Unless folks object, I'd be
happy to queue this up for 5.5.

-- 
Jens Axboe

