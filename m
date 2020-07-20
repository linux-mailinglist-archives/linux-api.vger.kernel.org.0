Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890AA226AB2
	for <lists+linux-api@lfdr.de>; Mon, 20 Jul 2020 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgGTQgv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jul 2020 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388832AbgGTQgn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jul 2020 12:36:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F24C0619D4
        for <linux-api@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a11so13883737ilk.0
        for <linux-api@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=IJM4F9kEuWWZ9HWNrJw+/v44b3wlVooucvBHu8ZYu8BUTGD5nEtsKNyzUXoTwNSTEY
         +bYLs/oEfkJ7TI+wg3wqDbe/+j2D8FZZ+9w2kK7V4HwSe+AzjwElQJfRiaflWvmPXZgr
         bXgpTKOrNGv2fnoAHU35bus/WtnzUUcC7j8iH6Sp3HbSK+FymkGn0BgI/YffgYLJR0ox
         sBgfdmHN6KCjmzreGDBnzbbO3cvKE4LDgna3CAHCOSG27AtgoCLXhS4OGzLlFFlF/CaO
         SvOcMUX2AWEnvyi4W69b4nj3DC+Yr5/MXaC6sOpNKcUKRHLr/ofvZzc87WX/VE814Tgs
         C6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=ULCMEnAegHPH4TUUNuuWH+Ch6UM36zj5x3MsdftGSm92aZ2OowR230OMKZmIE+0u6F
         13wUpjGBL+nwDpVHTq77DjZtr5ZLUiu1On7TW9j9rKcnO5t65LbFUxeZRHo5glj5weL0
         YEGE7bGc9Ajxccw4A4mXsGOWFbVx5ASkWDZ30p+7Du+O0HRAygtjnnVEL6r1U4rQMcUq
         N4PuBJHKdjOgnYEjTFwfhQzXO3apQuFe9H62E1pvkI6Y3mmSZHUU+bPoaI21IMaUSi4d
         LhhCCzK0ZjSziuSdPUHx0haF+jawNvFOOYlI+nyEgZ/ycIkcMc1FupsI+d7L0HomS1w+
         R4yw==
X-Gm-Message-State: AOAM533xNVtGFCLi7OPQ/pL0NwmyhgpAk9kfB8d3vhCc4SuxuH8QO5YZ
        FzZ8h6h+0ejIopj6YYVarDE9rQ==
X-Google-Smtp-Source: ABdhPJxukhVb2zn3N2KCfVMsxmqpS2RZySUveN6hPJ2GEvDdyWHhLuaqHOHq9wpkvxNqmBkiJFxtrA==
X-Received: by 2002:a92:7306:: with SMTP id o6mr23184732ilc.90.1595263002078;
        Mon, 20 Jul 2020 09:36:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w15sm9315257ila.65.2020.07.20.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:36:41 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200720061046.GA10678@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Date:   Mon, 20 Jul 2020 10:36:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720061046.GA10678@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/20/20 12:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I just found a (so far theoretical) issue with the io_uring submission
> offloading to workqueues or threads.  We have lots of places using
> in_compat_syscall() to check if a syscall needs compat treatmenet.
> While the biggest users is iocttl(), we also have a fair amount of
> places using in_compat_task() in read and write methods, and these
> will not do the wrong thing when used with io_uring under certain
> conditions.  I'm not sure how to best fix this, except for making sure
> in_compat_syscall() returns true one way or another for these cases.

We can probably propagate this information in the io_kiocb via a flag,
and have the io-wq worker set TS_COMPAT if that's the case.

-- 
Jens Axboe

