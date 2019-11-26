Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0B10A362
	for <lists+linux-api@lfdr.de>; Tue, 26 Nov 2019 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfKZRgM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Nov 2019 12:36:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38432 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKZRgM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Nov 2019 12:36:12 -0500
Received: by mail-pj1-f65.google.com with SMTP id f7so8613815pjw.5
        for <linux-api@vger.kernel.org>; Tue, 26 Nov 2019 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NtvB90Am5ZTLYm+Aanm0y4QmpQ4zRvwI0Pg1w2+PDpk=;
        b=rGNbv7Q/X/5vfOv3mEOUHT0ifP2BNEzSFwVUFi60A3yjv16WqHdBPaULOwt59Zn5jT
         gRvE//8RWtJpaj/TRQfMmRf6SBpTz2Y54xeympjIDF/o3ZrhXFas7GBOqXuO4RYEQokq
         DeGwcPrVZvj6zd6bHf5EGPJOWL4UEEQX7sImp33qn01RPtL3vw9ts8Lg9n4GyoDbCFD9
         UM3t9zmxGiVNPZatYm0w8uT0PYKSAv1YccttU0918i+7vjV/dtx5Fw2UcVFnXXV8IcOL
         LJ8UlYU64ghrRk56ahQOTQOWpwcXe1Ss0w/j2aWx47gGCqN2Xnt05Kw4FiDRlZv4LqvY
         Lj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NtvB90Am5ZTLYm+Aanm0y4QmpQ4zRvwI0Pg1w2+PDpk=;
        b=to1VvBDBDzD1ZVVs6hXNz53i77TCdgXtyMnmzSVefqsVV05tZr5FS2ZDUd/awkx4e4
         642FDbQtKYZ6mWgAn0l6WLQyDCjoplsnMkvJERX+4rf2/C20LskA7aDtxwijSKsvIc1h
         hMIV0OvsvBCQcZo0bf/dMbK8UI7a4ttjbZWXPChDwl+F2zDxcLgnwL8fbcrdwwIoKdyh
         uzp21V8xMKz1YhHKF7aoA5RbQgvBtYt5C6r+2Fq39Iwd6WHN6umfB44ePPHdKRcSApKi
         wqL7Dkdj18h9yPny7NZYJqaKOLTrhm62ubhZa55EtKclFv5mPXi+ON6ZwmlLtptIVWrF
         bhCg==
X-Gm-Message-State: APjAAAVBepX+b0437ydfMSyButeWu/I/s0ayNHc3ITtiHKfink0tUZbN
        ZD/EzA861n1R7Rb8Taz81UrtdA==
X-Google-Smtp-Source: APXvYqxQGleSEyUIqfvJa8/NiJsP5dYY2++4KZCeuP6V5fzHKL8ASxLjBD4+U8MsBGYZ6bwvbS0HNA==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr35712590plz.170.1574789771532;
        Tue, 26 Nov 2019 09:36:11 -0800 (PST)
Received: from vader ([2620:10d:c090:180::92f5])
        by smtp.gmail.com with ESMTPSA id c28sm13143566pgc.65.2019.11.26.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:36:10 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:36:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v3 03/12] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191126173607.GA657777@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <07f9cc1969052e94818fa50019e7589d206d1d18.1574273658.git.osandov@fb.com>
 <d1886c1f-f19e-f3a7-32d6-8803a71a510c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1886c1f-f19e-f3a7-32d6-8803a71a510c@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 26, 2019 at 03:53:02PM +0200, Nikolay Borisov wrote:
> 
> 
> On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> 
> <snip>
> 
> >  
> > +enum {
> > +	ENCODED_IOV_COMPRESSION_NONE,
> > +#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
> > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > +#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
> > +	ENCODED_IOV_COMPRESSION_LZO,
> > +#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
> > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > +#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
> > +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> 
> This looks very dodgy, what am I missing?

This is a somewhat common trick so that enum values can be checked for
with ifdef/ifndef. See include/uapi/linux.in.h, for example.
