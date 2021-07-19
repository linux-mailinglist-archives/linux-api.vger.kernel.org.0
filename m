Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8647C3CEFBA
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 01:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhGSWig (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 18:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387455AbhGSUJZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jul 2021 16:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626727801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7h6lI2j06CWA4PFkJ3/o8PCCfCme/nAjcw8Qib/v6k=;
        b=PngzR/ZQrPZnG2M0LRn9SGZ81UK4qhBJndV+HSQXX3kYFIfRQasmsPhL6BRJKZO9ffkJRv
        nZ2how7VtvdliRM26PFSXn6/1xIq/Zircx1bjGUiezoXkBjD1mBmhEi9mmj7Ea7XiqXljn
        Xv+lgOEUcQz2vbFuD4gaXhDYJnIQMr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-F8S3bULeOC-YlgsWDOGqDw-1; Mon, 19 Jul 2021 16:47:47 -0400
X-MC-Unique: F8S3bULeOC-YlgsWDOGqDw-1
Received: by mail-wr1-f70.google.com with SMTP id 32-20020adf82a30000b029013b21c75294so9351820wrc.14
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 13:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y7h6lI2j06CWA4PFkJ3/o8PCCfCme/nAjcw8Qib/v6k=;
        b=SIyry3/oXh1Xw2a65ZJkofWTA9cOib8K2XfI1aFIXQt3bHejeiE2uIIIT2bTB8z0xe
         E3drQOH2ZJoIysXLWu3iirqBX977HEGSvHN6L6m3KlMgKFLbpBzpTxQ4Rqqr79frlbra
         IOlhb5gGXmYSYanIncQqGG1+tdE4kakZ+Uscuzq5zHUdnWTlaenpqLBhiDPiVFqJUnq1
         JPu7WzLDeQi5ODetfrFHvsS+HhpYUQ0iYFeHM7runLO9iKXNNMsWBUOW7FxKUKKmgatU
         1w66RJvtj4vua5lOF0DvQ5NtZjVJo/Jr83JH4nxBjrronXYsqd4MvBBofSlf/ueqQYV8
         sVNg==
X-Gm-Message-State: AOAM531b9iaSVtJ8hRf6UL2uwpQYpTKA/GUx1M71UuTYIPHkjxnHqCGC
        Cy3Ig7VMbvTLiNchcFPNFd8doYnsbVJan49CFBHUajXz5HDYRMTBntaBJunUay4d7cJzQxZkUYJ
        4bReYzRUu2JjHW9RreXet
X-Received: by 2002:a1c:9851:: with SMTP id a78mr33923858wme.33.1626727666634;
        Mon, 19 Jul 2021 13:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+ujxOnHrTzwvaBYr/KTSEr8E7a6K4CcyuRHwDXhC9uinDQ3SXPRp7phK7pAIZy40B+WK+oQ==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr33923846wme.33.1626727666435;
        Mon, 19 Jul 2021 13:47:46 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id e3sm21662130wra.15.2021.07.19.13.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 13:47:46 -0700 (PDT)
To:     Peter Collingbourne <pcc@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210619092002.1791322-1-pcc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] mm: introduce reference pages
Message-ID: <3268d400-7435-f038-a1a1-f476adb03845@redhat.com>
Date:   Mon, 19 Jul 2021 22:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210619092002.1791322-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> +SYSCALL_DEFINE2(refpage_create, const void *__user, content, unsigned long,
> +		flags)
> +{
> +	unsigned long content_addr = (unsigned long)content;
> +	struct page *userpage;
> +	struct refpage_private_data *private_data;
> +	int fd;
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	if ((content_addr & (PAGE_SIZE - 1)) != 0 ||
> +	    get_user_pages(content_addr, 1, 0, &userpage, 0) != 1)
> +		return -EFAULT;
> +
> +	private_data = kzalloc(sizeof(struct refpage_private_data), GFP_KERNEL);
> +	if (!private_data) {
> +		put_page(userpage);
> +		return -ENOMEM;
> +	}
> +
> +	private_data->refpage = alloc_page(GFP_KERNEL);
> +	if (!private_data->refpage) {
> +		kfree(private_data);
> +		put_page(userpage);
> +		return -ENOMEM;
> +	}
> +
> +	copy_highpage(private_data->refpage, userpage);
> +	arch_prep_refpage_private_data(private_data);
> +	put_page(userpage);
> +
> +	fd = anon_inode_getfd("[refpage]", &refpage_file_operations,
> +			      private_data, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		put_refpage_private_data(private_data);
> +
> +	return fd;
> +}
> 

Hi,

some questions:

1. is there any upper limit or can a simple process effectively flood 
the system with alloc_page(GFP_KERNEL)? (does ulimit -n apply or is it 
/proc/sys/fs/file-max)

2. Shouldn't there be a GFP_ACCOUNT or am I missing something important?

3. How does this interact with MADV_DONTNEED? I assume we'll be able to 
zap the mapped refpage and on refault, we'll map in the refpage again, 
correct?

-- 
Thanks,

David / dhildenb

