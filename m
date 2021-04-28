Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9681536DE37
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhD1R1A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 13:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239745AbhD1R07 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 13:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619630774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7cB2m4EIXAgvJljHcfW/KYIdaLcxCsoC95kMJhMDAQ=;
        b=Iwi/VBr1bJVSiIAAiHHs4TG2GUCgrZMN0gSi7v+AKau5wP72tH/fH4S4OqPqRVlFP53lob
        k7tpWo739Jbl30sR/1ZgmDDHiXC2Mn5IIxkzOzYV/wFq8YIDdacuYFhYQIlY6RH5bWZkm6
        oT7x7l0TRASMI5Bh8wRcLPlXPrWEg44=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-zl48JFgwO0e2EFcJNSAZfg-1; Wed, 28 Apr 2021 13:26:12 -0400
X-MC-Unique: zl48JFgwO0e2EFcJNSAZfg-1
Received: by mail-qv1-f71.google.com with SMTP id w20-20020a0562140b34b029019c9674180fso28660406qvj.0
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 10:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V7cB2m4EIXAgvJljHcfW/KYIdaLcxCsoC95kMJhMDAQ=;
        b=t2G43Hw6VqmG+SINccsVVI1+A2AEz+LysQYQnn7fDLPpew9WF5oMUMZeSvFdQRb90B
         /NRRHfI1dvD1cgJ8r6n/UM2J9BIjQZpJ4PH4CXsy53KmZVvw3GSbt4ohkQt86TgXCuZA
         1hpj/2lucGU+fYfb+nJL7ks5Gl5Cru4wvgLE/OJ2uymJAmibhj1Pvyv8M8dzIc7ze2FE
         2ruCEbvglCBNVCNiQFVWXxcOLTPi04pjIv15zgFZ84rfcoFPlIfQnCMSmiuiNVJTuvlI
         xLoHVu0b6EX2PUX5eleA1cxReVImN4ZQWbhXdTXduOPp7SQRua52kOxlktsLzEuDW218
         4mKg==
X-Gm-Message-State: AOAM533ikgIPkcQ5S98t6ESqUqvcv5svJn/XU5tJ9s3soDr0rJcDm4Ip
        2J+cX9oKA8GAm/BstdV07clIk+wP32Ms97XFI2C2h4CjjzztadsYxjKdMK/uIVgtTsXLb7y1FkI
        iQKgL9C00wFz7B6ByOacV
X-Received: by 2002:ac8:424d:: with SMTP id r13mr20702058qtm.270.1619630771734;
        Wed, 28 Apr 2021 10:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Ithvw9uBEYJkRPtrVgmU9QKB0KQvBzCX+GB/l0kdWjFNNddPM4OsiueyR8oPGxwkUx7/sg==
X-Received: by 2002:ac8:424d:: with SMTP id r13mr20702038qtm.270.1619630771527;
        Wed, 28 Apr 2021 10:26:11 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm280259qkk.31.2021.04.28.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:26:11 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:26:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 10/10] userfaultfd/selftests: exercise minor fault
 handling shmem support
Message-ID: <20210428172609.GG6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-11-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-11-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 03:52:44PM -0700, Axel Rasmussen wrote:
> Enable test_uffdio_minor for test_type == TEST_SHMEM, and modify the
> test slightly to pass in / check for the right feature flags.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

