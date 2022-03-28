Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B34EA2F5
	for <lists+linux-api@lfdr.de>; Tue, 29 Mar 2022 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiC1W2m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Mar 2022 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiC1W2m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Mar 2022 18:28:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9762171577
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 15:27:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h19so13150980pfv.1
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaW6LnFnD0yHSZLOEoOdmGP4SdnTb3yLLH8IPqs77KY=;
        b=Xyvle5xj+iytheGd+opSaVUcJMrxydFolbbLLB0cfjcq5NLgRpKcyY8LmvKaLgqjGf
         4Wz+LYcSQ0FaI+N5y+VY4SzfRHCjtAZByjFVMXJ2KOnIAwrohQC+hThWqUCVqG+4NbES
         3SNF28Gr4dRvSXnzRTTpxIDvLztpdn1WZNrxh8Q8n7iGr0rCaj4r9+fp3XG393ZBWs6k
         SHSEkJqmZ3YIGgDpQAEgtvU4ck1H0tPnbq3AaPzkvTPpDKGc7uoyX0A9YsGMVeSengHe
         iGHaJiaF81xnBQn+5IhcSf8NxcBCjbS8eFYH7svcMpAomWcPYrKr0MsWl6ZnU5x0GLV1
         TUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaW6LnFnD0yHSZLOEoOdmGP4SdnTb3yLLH8IPqs77KY=;
        b=pqz9+GQ0BS36pAhpdnEuD+x+Mbpz13et19tFS5nsDbVrC40uP0jiU2PlFJZ3rTmBA9
         Dd5CtdiLLLrkCUZbRttZ9eCfudLCND4bOx4hRZp9+fXtdnSuVNVFCh5TJwxbQ6SIYbNt
         tDc/ha9ObaeA+frURE6JgqjvorYCKTmqb1JtpyyJFELTZf7Zt2L10gniUtioXgFeG8o4
         tnUHG0UYArAVVxsMdMbe3lvInxGs76EX63q0+v0OTQG+MVOg9ctcnnn8J4gbYFeOyYfw
         rjPHmmvQ1vnQrgZlh3mI2z/pXvksX4XqOWMQD0SENmyVcxVdWeU9LIXVP4TqPNxCGXIi
         pTRg==
X-Gm-Message-State: AOAM530V5NSvg3muh7pVAk9fFaO3ULXiIzIoFSVzosy5dj8U3s3146OW
        T4mtjzXD3vxfyzJ+NdY4wv6Hrg==
X-Google-Smtp-Source: ABdhPJyCCih0kMQlx0T3Lnxi+OwtGBTbKYzIPbgZGi6J5hxjxW3HSWsT0UQDj72qn+FBmxrSiRdwKg==
X-Received: by 2002:a62:e215:0:b0:4fa:87f1:dc16 with SMTP id a21-20020a62e215000000b004fa87f1dc16mr25067148pfi.19.1648506420043;
        Mon, 28 Mar 2022 15:27:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b004fb358ffe86sm8955991pfv.137.2022.03.28.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:26:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 22:26:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 06/13] KVM: Use kvm_userspace_memory_region_ext
Message-ID: <YkI2Lyv9SJaGPDz+@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-7-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-7-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 10, 2022, Chao Peng wrote:
> @@ -4476,14 +4477,23 @@ static long kvm_vm_ioctl(struct file *filp,
>  		break;
>  	}
>  	case KVM_SET_USER_MEMORY_REGION: {
> -		struct kvm_userspace_memory_region kvm_userspace_mem;
> +		struct kvm_userspace_memory_region_ext region_ext;

It's probably a good idea to zero initialize the full region to avoid consuming
garbage stack data if there's a bug and an _ext field is accessed without first
checking KVM_MEM_PRIVATE.  I'm usually opposed to unnecessary initialization, but
this seems like something we could screw up quite easily.

>  		r = -EFAULT;
> -		if (copy_from_user(&kvm_userspace_mem, argp,
> -						sizeof(kvm_userspace_mem)))
> +		if (copy_from_user(&region_ext, argp,
> +				sizeof(struct kvm_userspace_memory_region)))
>  			goto out;
> +		if (region_ext.region.flags & KVM_MEM_PRIVATE) {
> +			int offset = offsetof(
> +				struct kvm_userspace_memory_region_ext,
> +				private_offset);
> +			if (copy_from_user(&region_ext.private_offset,
> +					   argp + offset,
> +					   sizeof(region_ext) - offset))

In this patch, KVM_MEM_PRIVATE should result in an -EINVAL as it's not yet
supported.  Copying the _ext on KVM_MEM_PRIVATE belongs in the "Expose KVM_MEM_PRIVATE"
patch.

Mechnically, what about first reading flags via get_user(), and then doing a single
copy_from_user()?  It's technically more work in the common case, and requires an
extra check to guard against TOCTOU attacks, but this isn't a fast path by any means
and IMO the end result makes it easier to understand the relationship between
KVM_MEM_PRIVATE and the two different structs.

E.g.

	case KVM_SET_USER_MEMORY_REGION: {
		struct kvm_user_mem_region region;
		unsigned long size;
		u32 flags;

		memset(&region, 0, sizeof(region));

		r = -EFAULT;
		if (get_user(flags, (u32 __user *)(argp + offsetof(typeof(region), flags))))
			goto out;

		if (flags & KVM_MEM_PRIVATE)
			size = sizeof(struct kvm_userspace_memory_region_ext);
		else
			size = sizeof(struct kvm_userspace_memory_region);
		if (copy_from_user(&region, argp, size))
			goto out;

		r = -EINVAL;
		if ((flags ^ region.flags) & KVM_MEM_PRIVATE)
			goto out;

		r = kvm_vm_ioctl_set_memory_region(kvm, &region);
		break;
	}

> +				goto out;
> +		}
>  
> -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> +		r = kvm_vm_ioctl_set_memory_region(kvm, &region_ext);
>  		break;
>  	}
>  	case KVM_GET_DIRTY_LOG: {
> -- 
> 2.17.1
> 
