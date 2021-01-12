Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811522F254F
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 02:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbhALBNe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Jan 2021 20:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbhALBNd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Jan 2021 20:13:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBCC061786
        for <linux-api@vger.kernel.org>; Mon, 11 Jan 2021 17:12:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j13so622602pjz.3
        for <linux-api@vger.kernel.org>; Mon, 11 Jan 2021 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeroSUVjjmC+Oi1TznGuZqpsMLfJSMPO+vq+1KmDVOY=;
        b=eh3zl5GxXEYsEZi6yuaetcvNkJbsOPeSlI99r6w6+7dicC5rvtqC81rRI/VOQFtIVC
         8RDAFZbcqMf72vNe80Ux6BOjdoCVwQEfACLjtQBWn8W02nAUK4QiR5WpPxLZy4FQXNSG
         bTwU6ywKdhHi3J/GglPA+iyXCvAEk2QagSGKXk4Woz0M/A0+WybRt9hp9NVK1cX1RQIU
         qeQpheXPopxYcL9OZ5gqX22NdJPSw1gAESQkovLj1Q7UJR+4yZix50BIcwqZftgllBVC
         X5NCmW6DUy6srOhc6rTOK7zYFJHIqvKDtQOuTnZCwryddZ/17xuF0JTmskybdyoo8lSF
         OxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeroSUVjjmC+Oi1TznGuZqpsMLfJSMPO+vq+1KmDVOY=;
        b=ulwN8kVtuaUcC5Ss+pvqbjF4Se2hO58AJbdO0eJeoXXxuJZVUCqnBdyDj7gvQn7W/t
         f556tm+4Bs82gEJeczk2zn1uNLQ8kkyceSrKLDTJmGTe2+G/MSRtAdbu2Yu+6XB2mfl3
         skRklVfg0F9wkRhqJCAhdEIckhByJvBdDwjpMM/GgJIx2lcUzQdb9f+kvOOdRml1NC6d
         OvWlsRpWhhs9kNEIE2PHSdZsw1w0202IxV4zGtM1+BlZ3sdxK7r8wZFB8mRN093c5JiH
         rsl+A9MaSRTTwZv68HiJF//D1krZZuFtNJ+NZaVn6KlA8QjYnyKuPgsOmN93fqZN1Mvl
         j4xg==
X-Gm-Message-State: AOAM533Yb2QrsxwefXPGWB5hmCZvy44bQYt9bS04qjVZLIO2enG1nvtN
        +/Zk/8yScqknRCVzpG+5vKBOjw==
X-Google-Smtp-Source: ABdhPJxRF0FNun799Re6m0Dlhn3msDTubi+Ca34uUaYeDXhd5YM/gQp4x/Eq+sUbStMDe7j70fv8hA==
X-Received: by 2002:a17:902:7c04:b029:dc:99f2:eea4 with SMTP id x4-20020a1709027c04b02900dc99f2eea4mr2508598pll.43.1610413972364;
        Mon, 11 Jan 2021 17:12:52 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:675])
        by smtp.gmail.com with ESMTPSA id o7sm921465pfp.144.2021.01.11.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 17:12:50 -0800 (PST)
Date:   Mon, 11 Jan 2021 17:12:47 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: Ping: [PATCH man-pages v6] Document encoded I/O
Message-ID: <X/z3j7dtRrAMc8wC@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
 <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
 <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
 <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
 <7e2e061d-fd4b-1243-6b91-cc3168146bba@gmail.com>
 <48cc36d0-5e18-2429-9503-729ce01ac1c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48cc36d0-5e18-2429-9503-729ce01ac1c8@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 18, 2020 at 11:32:17AM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Omar,
> 
> Linux 5.10 has been recently released.
> Do you have any updates for this patch?
> 
> Thanks,
> 
> Alex

Hi, Alex,

Now that the holidays are over I'm revisiting this series and plan to
send a new version this week or next.

Thanks,
Omar
