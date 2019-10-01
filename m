Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C2C3942
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfJAPio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 11:38:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41431 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbfJAPin (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 11:38:43 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so20588215ioj.8
        for <linux-api@vger.kernel.org>; Tue, 01 Oct 2019 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4oki5zqaQqD9Lw/LHfcoqYFe2cd/ERA90a/rseIBMo=;
        b=WiIT9lAWvLNqkJPLDmK3wtxUBnf7YlD0Y/kELsZ+76TlnDPSyvunE5wo0RbyKXRFQa
         q5XkTSz7HmMAj2RYgO68VYiCeT4dPWF9dFle0DmUC+RRFWbiqODHQKrf6ih1DOQmL6VS
         9As5ceqbUSx+qr7H1jLjg1uiMSRImQoyzxisdZcAuM6EPQsnNGcvPq442sxIo4wtMvR4
         hEJCIm2A/RAc8xGf197TveBDYPhwudyteTXmi6+ZT4JdJPLzmQvKfMh+wCMgOB/F4ozv
         dib8PFFKWS0wJQNjaZVYrDfvDvdpjICYt5QmdIxLfh0PELHRPwnfMu2bXy85jgG/ND9Y
         /2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4oki5zqaQqD9Lw/LHfcoqYFe2cd/ERA90a/rseIBMo=;
        b=kym6deXhdMThR7NVZqFvwVhOF/qGUdt0bm2fsncxSD0OefajgIeX9r2FDuaSBeGCxk
         lBBuZGkzweBNS8dOrX3xZ6G37crZHudjBKSlD5T/b9X/E1N5Snpt6Xs/NcneCIxe89ip
         JEfi/xIer5Ip/4qCT8h6PZ//y9/y8FCvTu0iMyWDHJCxWBULdbzxNHOGxQTufkhdSEcu
         UBzGzENGkWZK1Tgw1W45fw+aVX+uewPdrF4dL5V8OrdIYWwp5pk92Du5iVvVZentm45z
         cAlHuuRTZHWgS9MvVD9ZT8shi3KEIDAXQVMNfd1C6bQCUPjCRMYZ+4zju9clW6FcoULJ
         1ISA==
X-Gm-Message-State: APjAAAW1ZDsy17n7LuewdGWOrQ4SiHFXGzNpW0dvoLKquN6A4F5ZFTsN
        YzpZOQD8nwrQRF8Ttgd4CrF4RAsCVCXDdg==
X-Google-Smtp-Source: APXvYqwx+6EDi1cZu8EVpD4waPECZ30FL4SJH4ERBjWjw+ax3CYgRlOg/ieHHI4DCViinpHplbgtRg==
X-Received: by 2002:a6b:9107:: with SMTP id t7mr11078862iod.150.1569944322839;
        Tue, 01 Oct 2019 08:38:42 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t24sm7118469ioi.44.2019.10.01.08.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:38:41 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190930202055.1748710-1-arnd@arndb.de>
 <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Message-ID: <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
Date:   Tue, 1 Oct 2019 09:38:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/1/19 8:09 AM, Jens Axboe wrote:
> On 9/30/19 2:20 PM, Arnd Bergmann wrote:
>> All system calls use struct __kernel_timespec instead of the old struct
>> timespec, but this one was just added with the old-style ABI. Change it
>> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
>> the need for compat handlers on 32-bit architectures.
>>
>> Any user space caller will have to use __kernel_timespec now, but this
>> is unambiguous and works for any C library regardless of the time_t
>> definition. A nicer way to specify the timeout would have been a less
>> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
>> change that as this would impact both 32-bit and 64-bit users.
> 
> Thanks for catching that, Arnd. Applied.

On second thought - since there appears to be no good 64-bit timespec
available to userspace, the alternative here is including on in liburing.
That seems kinda crappy in terms of API, so why not just use a 64-bit nsec
value as you suggest? There's on released kernel with this feature yet, so
there's nothing stopping us from just changing the API to be based on
a single 64-bit nanosecond timeout.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index dd094b387cab..de3d14fe3025 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1892,16 +1892,13 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned count, req_dist, tail_index;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
-	struct timespec ts;
+	u64 timeout;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
 	    sqe->len != 1)
 		return -EINVAL;
-	if (copy_from_user(&ts, (void __user *) (unsigned long) sqe->addr,
-	    sizeof(ts)))
-		return -EFAULT;
 
 	/*
 	 * sqe->off holds how many events that need to occur for this
@@ -1932,9 +1929,10 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
 
+	timeout = READ_ONCE(sqe->addr);
 	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	req->timeout.timer.function = io_timeout_fn;
-	hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
+	hrtimer_start(&req->timeout.timer, ns_to_ktime(timeout),
 			HRTIMER_MODE_REL);
 	return 0;
 }

-- 
Jens Axboe

