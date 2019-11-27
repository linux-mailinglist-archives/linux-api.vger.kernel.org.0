Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6290B10AC6A
	for <lists+linux-api@lfdr.de>; Wed, 27 Nov 2019 10:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfK0JKU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Nov 2019 04:10:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK0JKU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Nov 2019 04:10:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so10508700pgh.3
        for <linux-api@vger.kernel.org>; Wed, 27 Nov 2019 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b7QOe1FC70muESaz9+PbY6FufdbspFqUvVZugA4Sa+U=;
        b=0koaoRgTcCXSbsVMOueG/T1xOoCZjxRg7Ck1FnRhPBQpjQL8TDUssP74bTyJ8kO3Yo
         fdzH/H9Q2b0SAT8KoRvvHS8UbFWC20phZRtVdomf5sddxeyyRIBM6Wrq57nWYJksCyyB
         5U/taeGmZu5+IwwgrxGaBIfpS3sr0RNemBeV6FUIMJdalnTTD1ZCbFxxVhMitRQ1sZaX
         sfMSyNK/R8AY2IfmxU2Av7kifDFIAWsqZvd84DsLXYyHo/bfHVhZQembtiw1xj+Z8zBp
         3tzZ8NI7ztt06WFVwwLwums3NhoR2V2vyVzxwOxh5Nv0PYXJe7PFY/Fg/Hppfm7BHg7z
         sGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b7QOe1FC70muESaz9+PbY6FufdbspFqUvVZugA4Sa+U=;
        b=KuFyvgR5inXYuR1dIXzvnz62lSkQXpt1c8Aktbrc8w3c8OeWxOOQkgcvMWCI6NB7F1
         nENbr9c2jqcOB9bsn2SZifQOkKwIZs1Yn1B8VVf0CyzO6Ox7ycL1TuG0VoWWOwSRrwMn
         xO2RUSyiQTPBXG5X4U0UDshHT6lcZywR8U3U2ui/hBLzPAR+PEU2bQvAoV0AqEXB+aOI
         uGJVLgN5K8QaNF5FP5cXzIKw0xjWce3TfdetlrjG7GI7EyCe9JlfHVkf2YQhU4/d5U/D
         /WVDd5TCia9g+Avoet7YnxiXfEf+xWJ/EDgfKTZi66h35XGMxKbeW53GdFACaPCSeg9e
         REoA==
X-Gm-Message-State: APjAAAVfHXr2tlvEWIas7zM8AI4EOb4PcxxFgWxvztEyhsue6y+JtJc0
        mLVyhE7C8eTfQJEtYLAqFy5o7A==
X-Google-Smtp-Source: APXvYqzy16Q7SuEKGV2/xSlWDFfb755gazILIRyDnfF1b2B7Nx18qVkR3Eu9ZcpFAzfP7Qq95Ey0OA==
X-Received: by 2002:a65:55cc:: with SMTP id k12mr3818296pgs.184.1574845817569;
        Wed, 27 Nov 2019 01:10:17 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id r203sm15762366pfr.184.2019.11.27.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:10:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 01:10:14 -0800
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
Message-ID: <20191127091014.GA745151@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <07f9cc1969052e94818fa50019e7589d206d1d18.1574273658.git.osandov@fb.com>
 <d1886c1f-f19e-f3a7-32d6-8803a71a510c@suse.com>
 <20191126173607.GA657777@vader>
 <73e9b52f-afed-fa0d-5463-222e41fead56@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73e9b52f-afed-fa0d-5463-222e41fead56@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 27, 2019 at 11:00:15AM +0200, Nikolay Borisov wrote:
> 
> 
> On 26.11.19 г. 19:36 ч., Omar Sandoval wrote:
> > On Tue, Nov 26, 2019 at 03:53:02PM +0200, Nikolay Borisov wrote:
> >>
> >>
> >> On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> >>> From: Omar Sandoval <osandov@fb.com>
> >>
> >> <snip>
> >>
> >>>  
> >>> +enum {
> >>> +	ENCODED_IOV_COMPRESSION_NONE,
> >>> +#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
> >>> +	ENCODED_IOV_COMPRESSION_ZLIB,
> >>> +#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
> >>> +	ENCODED_IOV_COMPRESSION_LZO,
> >>> +#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
> >>> +	ENCODED_IOV_COMPRESSION_ZSTD,
> >>> +#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
> >>> +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> >>
> >> This looks very dodgy, what am I missing?
> > 
> > This is a somewhat common trick so that enum values can be checked for
> > with ifdef/ifndef. See include/uapi/linux.in.h, for example.
> 
> I cannot seem to have this file on my system (or any .in.h file for that
> matter in the kernel source dir).

Whoops, that should be include/uapi/linux/in.h
