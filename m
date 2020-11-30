Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD40D2C8DDA
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgK3TTZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgK3TTO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 14:19:14 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37DC0613D6
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:18:33 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so195169pjt.0
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J0uaPww9Zo/kwiIz62BRZcQJ75KrUIs2Bl30icME+Dc=;
        b=TXpn7lbrUrUILSPcmkpNm9ho9lyxtnMhvLUZTDTKTkfhqgufluqLhBWTfWZi9ML+Ul
         6MLS5fKcBK/W/JorbbRmkIHIrz+5iM7uRTQ1D+FBUX8mSAnu9bXf98kkV7m/+upab/3s
         NYrJKb9Pv2tRvzoYgskwZ4aDTv2GjtsRz8nBiA7nDZiPK03YMTiOr5QJM4gjdfSEtf/J
         ZWkAJLvVcd2Afx8D9O9ZFdi4mX76DLvXW6ozrmLdQira//F3CF4O0H+FoyKVe4TbyRab
         ES0SBeNjt3Gij6gblWH3wFKIPd21mg3ymfFHZ7c6WVSh7AG1vLCVNGvb58ljmDgBTK5J
         fLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0uaPww9Zo/kwiIz62BRZcQJ75KrUIs2Bl30icME+Dc=;
        b=b/z83tiqBnkZoo+LM88Y4y3mMVLm9Te9Yga8I48WgRryORFJxj9cTjVlPlwR5BX/T5
         GD1bOkJxTh6dJ/vE8cPw3Rvi2QAfoNGc09RdnjQNtbBLLEEne6PYJxmvUf3LaGS6oXwA
         ozgnl1yBe9FeyaNInqwdAw5oW8yl7KFmaRWClx7/FnTIsmTPkrw5ZDvmUxmQVRQ5FTyk
         Gb5Mb2JYYZk0wpAoMdwqq2iTYjx5sg6Zrab1Vo6uoMbVjYfUcOCIzHikMKtO0HhnL10m
         BcsqcvaYFkOW/YjYrqoc0iHh0DVlVn/NhAvDB5+yyDXRJqmLih7cz63IiiErw/aEIx/X
         Vk+A==
X-Gm-Message-State: AOAM532OuA3AC0PWXOw7ZrOk21wm1FI0toGkN3TcTq7tZqNapIy/m91/
        SbV0yGn7mOKfME8Z05cXOx4xAg==
X-Google-Smtp-Source: ABdhPJxV8so8Tk7xlVbSlSNLCUfIRq2duNU3cGTYClzBLepW/PJI1vbrV4KpO4SQjmioJT/24Su3cg==
X-Received: by 2002:a17:902:b209:b029:d8:e821:efc6 with SMTP id t9-20020a170902b209b02900d8e821efc6mr19864273plr.5.1606763913184;
        Mon, 30 Nov 2020 11:18:33 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::b2be])
        by smtp.gmail.com with ESMTPSA id v23sm17759258pfn.141.2020.11.30.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:18:31 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:18:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 04/11] btrfs: fix btrfs_write_check()
Message-ID: <X8VFhiqOVZKh+i6e@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com>
 <20201123170831.GH8669@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123170831.GH8669@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 23, 2020 at 06:08:31PM +0100, David Sterba wrote:
> On Wed, Nov 18, 2020 at 11:18:11AM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > btrfs_write_check() has two related bugs:
> > 
> > 1. It gets the iov_iter count before calling generic_write_checks(), but
> >    generic_write_checks() may truncate the iov_iter.
> > 2. It returns the count or negative errno as a size_t, which the callers
> >    cast to an int. If the count is greater than INT_MAX, this overflows.
> > 
> > To fix both of these, pull the call to generic_write_checks() out of
> > btrfs_write_check(), use the new iov_iter count returned from
> > generic_write_checks(), and have btrfs_write_check() return 0 or a
> > negative errno as an int instead of the count. This rearrangement also
> > paves the way for RWF_ENCODED write support.
> > 
> > Fixes: f945968ff64c ("btrfs: introduce btrfs_write_check()")
> 
> This patch is still in misc-next and the commit id is unstable, so this
> would rather be folded to the patch.

Looks like you folded this in on misc-next, thanks!
