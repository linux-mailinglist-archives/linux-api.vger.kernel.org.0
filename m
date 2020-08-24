Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BEB250938
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHXT0L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXT0J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 15:26:09 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE4C061575
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 12:26:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x7so4331255qvi.5
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FGxrUP/46z6gtCVukhkzhLpnc2XBY9sWwEBOg2M+TJo=;
        b=WB7Av64z+q/mkhbCDInXJU1JL2a34/ThOai0eJwSncYCW+Ls8MfJQsEDXGT0F0xtM8
         bSMntBSXTWdESBuqEXqQx8aBJVlc2wWJoZMSM7nvR1nzgWeOGj8Y9M0A7Dz4QHcXnTSr
         MKByeAM7ELOf+ljy2sRZJvp7nA2ltfFuJ6mNo07gNdeY4O9rx8O5MzZA565vTnCQEIwu
         0HJvLS+k5PudOdGHGxUH7b8K/MG1xbXsUM803oT4hGP+SLWuw/N8xE8WHWKTI4WLSEWR
         NQjDS0YfhEp/hKs6WCiziRXUlJqSpT0FJi8YmNo2a3gHE4xlfAruVYBCcjCtzmM9Skqk
         kA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGxrUP/46z6gtCVukhkzhLpnc2XBY9sWwEBOg2M+TJo=;
        b=p32Vdva14eqUzlGfdTirgxD+Al/SHzcbneawcHxqjuYizw8FujKV0ytLU/e/B73TgU
         jkzjTAsMCbY6lMcGVgQ5M2Lv1KX+qeGdskTcrPrrJlRSnT6j7+yae7f2bAWQQ93tq/iw
         H0aE5vkbwmxamYfE0j6CK+hw5PvSYjA+VErjfuDd2IiCpweO8ydk8a66T0Vk4vfdT+/Q
         hBum4o74XPRe6gEqvQx2iKnyGn5A3QXPZ2qpmr+e2IDUWn3oKs8W3+mdYAOivQZ8lKiV
         f2IG7kdakQ3xyOi3drQw9ghrp3e9zDJ1pLbgCRYc2GLexBmDLwxyjd8sTfkikwJ+rTTI
         DDOw==
X-Gm-Message-State: AOAM530rwjhoHxRjSV+/dHaszpY7StqnuO5qOadB54Sv0UhZsdgYJD6D
        j6OHiYw34ifByYruYjfTy1rcBg==
X-Google-Smtp-Source: ABdhPJy7zuuIAszMep8G+1EjFAi81oKO2fcArHlpwjxgxVXH9GJZmXJRBzi1/OdCQHp/NwOyYgDPUA==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr6315491qvz.216.1598297168190;
        Mon, 24 Aug 2020 12:26:08 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q9sm3417596qkq.82.2020.08.24.12.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:26:07 -0700 (PDT)
Subject: Re: [PATCH v5 6/9] btrfs: support different disk extent size for
 delalloc
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <61dd1001b124fc1b09e43e27b804c5f8d597640a.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e863983c-bc5d-0546-8efc-10404cc48432@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:26:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <61dd1001b124fc1b09e43e27b804c5f8d597640a.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, we always reserve the same extent size in the file and extent
> size on disk for delalloc because the former is the worst case for the
> latter. For RWF_ENCODED writes, we know the exact size of the extent on
> disk, which may be less than or greater than (for bookends) the size in
> the file. Add a disk_num_bytes parameter to
> btrfs_delalloc_reserve_metadata() so that we can reserve the correct
> amount of csum bytes. No functional change.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
