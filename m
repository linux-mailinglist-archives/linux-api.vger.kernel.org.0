Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E148CC36B0
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfJAOJW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 10:09:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39083 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbfJAOJW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 10:09:22 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so48286525ioc.6
        for <linux-api@vger.kernel.org>; Tue, 01 Oct 2019 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=Ghk4OsGG6Oz7tZ5M6eRx1P6XEdLbmrF2aEY6vccsaJberBmlyClMkjTnCDUvfgSoy8
         oNi1eKeNRo3+bYcSn0gvIlsZKya2riDbF2MmiNMpb7tr9rGA5cB4bFPRVNLp4ol9yMiW
         QOU8U5m+QQemvlzF+O/n94HQ8AEX+KydRPxZLaXLyFrOhBDD0qb8JoT7+7HaiAsuSv5X
         3yeuYt/vsr2NBT/WYeEUw/mYX2/5yk5mfMBYthUynDq3HY2i1hMmJq87rszhxXsnTUL4
         vfcatmG2SXm3yADHfu0rFgwrswiTFriyhC9Ak6WlppWNDCzwuRW1URjT03nKqaIGOZ8v
         YlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=Gq1nFSSbwvvQOwd4jVby+zCMmEAepz+e7iTnrAeMTk+6QGblyFLK2u1+05oNym0HWv
         /UTbfG3OswO+Epjfjt6FvKh9Mt/1+pwxTwPgsUtg1dNmvaqCCe33MSUjbUUXwG3DfiDp
         yISKMuEnyqGcCFchclUv4yW/6xdtTOvYWeQ48mGI9iTLyDGbFNqfOlbh4nGBWQl+K90c
         6pa4ELeJET64ymmqd1oKjJw9V1couq1guTPStsqbngIAj3yczsOXJdOoq1zkVvX/w/QG
         12NeMk4WMKFhSBRWyDl3/gOu82tSnB6EKIYWqPTc9AVu+1Nm6WrKV+8aqQK8jhMO8ZxW
         YEZA==
X-Gm-Message-State: APjAAAUagGokj4C2Vmomc8Y8FUYfljcwRcoDWufPSr49WtV5NqP5Niae
        liPOc+3sxzh3CqDdK5/rvzFVkw==
X-Google-Smtp-Source: APXvYqwIU8KTZ8E+y38iJxYiNYbx3DqPrbV92LcVOROG8LhAavzL5GtuetwG67KAKXV7C4rnKXRPBw==
X-Received: by 2002:a92:6507:: with SMTP id z7mr23935789ilb.191.1569938961846;
        Tue, 01 Oct 2019 07:09:21 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm7177343iod.42.2019.10.01.07.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:09:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Date:   Tue, 1 Oct 2019 08:09:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930202055.1748710-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/30/19 2:20 PM, Arnd Bergmann wrote:
> All system calls use struct __kernel_timespec instead of the old struct
> timespec, but this one was just added with the old-style ABI. Change it
> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
> the need for compat handlers on 32-bit architectures.
> 
> Any user space caller will have to use __kernel_timespec now, but this
> is unambiguous and works for any C library regardless of the time_t
> definition. A nicer way to specify the timeout would have been a less
> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
> change that as this would impact both 32-bit and 64-bit users.

Thanks for catching that, Arnd. Applied.

-- 
Jens Axboe

