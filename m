Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975DE1D04F1
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 04:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEMCa4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 May 2020 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEMCa4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 May 2020 22:30:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AEC061A0E
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 19:30:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so7335977pfg.2
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s30LFx1aW+wj1WXhYvs6vLm6N7QrdlEvC0cIDKY6hWY=;
        b=X5DKCBbL6h1aumMxEijHJ/83zfL5mqXeCiEM6B8/RQdQJTtuBO5ImrRgl3aWuMdvKe
         fN39xdTOmnWSFzg5cjwBaVLf5ts7Ad84c73SR1p7RlEjFlHeqs3ihvF7IOcHf0X5YbT8
         a4bn7jaOUl4YYRiky/E9AlnBhBrb97PnJu/ZWhIPM+HlS0ycY9fv0MZXKOzuOxo+VevE
         LjvaN2Q3X85Jy/hC9yybPGmvI+G1LhCPxE7pekdSfIMekFduktP6KLkZI6FpJTLIL01u
         voskqJWPA5lm5P61oy8HcBq2bGsatqnmQBTBykW2nCIb14n+g9ywe9ImlUH9RrNefqjk
         7UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s30LFx1aW+wj1WXhYvs6vLm6N7QrdlEvC0cIDKY6hWY=;
        b=cXgoc8928fimTIOwNo1u61TRaKKlg76GLuc2YmQK8yxkW7OK0AV4HRJrSgNNWw/TSR
         jIq1wA73d1nbf6XA3VLv7a60ptGWdbge6p0dVR/9QFeKyFmjyY2ZsfEgGfieAeUckVi6
         NwXBLntCSApaamqQAwhnREJJIht/6gmC8jPMzexTEhUK/VmS+8Ky/80He1IjywKCJ79n
         kiy3uXFnTaLBcZPr7W4PVqwKa+Aq6pTElXv6+H8KU1qcpB8/UsaPhsZ9FJgKXUke43Zg
         eBasH3LtIAmNaywzDbc8jb3rjIJDhS8L3YhAUKqfPzXOcabzBBUi+5cBJ7NuiaOGA2tv
         V1+w==
X-Gm-Message-State: AOAM532jTUDJust/sEZDJYJGLTw0U8Drrwb2Z/qvOlZFFpv5gTHMnBeu
        2kf//mdCaQXR7ompT4sY1fNyFg==
X-Google-Smtp-Source: ABdhPJxO+Z3ab4Ulh2jdsBRUUIjwSNOJMXnCQaQZ2uiMX7yesBHiFN61UvD6/LCaQlLV3ZUrO4vtDQ==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr12718035pga.358.1589337055751;
        Tue, 12 May 2020 19:30:55 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id o21sm13740330pjr.37.2020.05.12.19.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:30:55 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
From:   Jens Axboe <axboe@kernel.dk>
To:     Martijn Coenen <maco@android.com>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20200429140341.13294-1-maco@android.com>
 <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
 <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk>
Message-ID: <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
Date:   Tue, 12 May 2020 20:30:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/12/20 8:29 PM, Jens Axboe wrote:
> On 5/12/20 12:46 AM, Martijn Coenen wrote:
>> Hi Jens,
>>
>> What do you think of this series?
> 
> Looks acceptable to me, but I'm getting a failure applying it to
> for-5.8/drivers on this patch:
> 
> Applying: loop: Refactor loop_set_status() size calculation
> 
> So you'll probably want to respin on the right branch.

Then you can also drop patch #1.

-- 
Jens Axboe

