Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B7250A85
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHXVJO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 17:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXVJN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 17:09:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF58C0613ED
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:09:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so2137508pgd.12
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mXzq4VFpfuTDMAhROUx/v2Tiks/oGuPIrAnlV7pgL4=;
        b=zTHfp5qr9CXMgLDiKCc7NSmUQwK6QjM2JRLdQcH/DW7bFmEVhszUdGCy9Vil82o0c2
         8yrnc6o7DnNlnvV49BeADtWAycT76MkV3D96tx3jqQi51qoxIosCT3a2NMgtcoId7+fM
         da8TR20fUZslEmqDKgIlbRZLf49p2cUEAIiRvModUkvSYMG0MmAxAEhh7KZE+uAFBjo5
         4rBX0rtPmzRQxV3uo86JpUHRkkufs3g+MwpOiNhJMUI7CLB0CXD8vPGOAQ7pSTcCvuyS
         BFyZm4Log32Szpc+5RJVCbTso/pMTlpbwHFCs8MaqXlSRIdH7q+9LI7cFIpJpl11HfpY
         /qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mXzq4VFpfuTDMAhROUx/v2Tiks/oGuPIrAnlV7pgL4=;
        b=sFvMWeiKzRZ/RwQfpNIUine89XNrLhvclr8OK7x3LvaEGLkzxwi1hFIhPs33h7xrtb
         jiBjHitMfpzIPxFcHPXdIKj/OQh5pK+80vlc/NRwk7nyRl0cbXIo2u7S5A6M8unuT6tz
         bvtU1meavuvG/u+y/9zkWt/Q7XLW3DlsKsZi8fwQEgI0p1qzhm1vLhP9sMaBaMqdWNdr
         9QVDwqMg1Mop3wl0zSsyo2mH/d0B6EZdBWq3KNonlf9dUwIiwGX4gTSfE61H0Nvyswgy
         JaM8bnq6AEdf9Ufj5zbsbECIpewJZhfhCp5bgQFKRUhI2CzfMqRah+T3PjhUDTwTkH4Z
         cTTg==
X-Gm-Message-State: AOAM533DyxUEuM2VkZ6nRyryUBrQbAqJASVU2jVxbTTljfKreuK8hGYF
        2IMVJccYbm8341K1Jw9lrt1JLQ==
X-Google-Smtp-Source: ABdhPJzBAcC6lTewhNgiycLtkJLMlcv1GmqUho/7ezq+g/7n5HwmWJRm1mNtwP4WW1HLG2qQ1hlzKg==
X-Received: by 2002:a63:e703:: with SMTP id b3mr4510239pgi.39.1598303352545;
        Mon, 24 Aug 2020 14:09:12 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:8d5d])
        by smtp.gmail.com with ESMTPSA id 13sm12677300pfp.3.2020.08.24.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:09:11 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:09:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <20200824210909.GA197795@exodia.localdomain>
References: <cover.1597993855.git.osandov@osandov.com>
 <8010f8862ec494c631b1d7681a6c5886d12f60df.1597993855.git.osandov@osandov.com>
 <93eca2d1-f72c-2181-b6a4-7015886f2418@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93eca2d1-f72c-2181-b6a4-7015886f2418@toxicpanda.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 24, 2020 at 02:52:24PM -0400, Josef Bacik wrote:
> On 8/21/20 3:38 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This is essentially copy_struct_from_user() but for an iov_iter.
> > 
> > Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> This took me a lot longer to grok than I'm proud of, but the idea is you'll
> have a single segment that represents the incoming encoded data, and then
> subsequent segments will be the read/write buffer, correct?  The code looks
> fine to me,
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

Yes, that's the idea for RWF_ENCODED. This patch is the generic way to
shove an extra metadata struct at the beginning of an iov_iter in a way
that is backwards/forwards compatible.

Thanks!
