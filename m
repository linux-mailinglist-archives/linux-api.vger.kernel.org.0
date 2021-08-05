Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF13E1A61
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhHER3l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 13:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237413AbhHER3k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 13:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628184566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vx6Eap2OuxsPf1499Uax7Ttsx2qtwc6VR8SU5LEnWZg=;
        b=BG5AIWKWsTc2kutuwkIbxzdEQfTUkw9oaZINs4bY1UGv8n6yf+NrAbhZ0GU25VQ34TuTcS
        XeSmDztrnStKloxHzSJK76n2UfKDA1xi2Zs9DPTC8T4fN33MC7RXKz/n6S9tGL8RCImYLq
        tC7j2bratgws+n0sAzHC7BOmV8Vg8n0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-5L6obGkgOimnpZq7ITUKew-1; Thu, 05 Aug 2021 13:29:25 -0400
X-MC-Unique: 5L6obGkgOimnpZq7ITUKew-1
Received: by mail-wm1-f71.google.com with SMTP id e21-20020a05600c4b95b029025b007a168dso3132266wmp.4
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 10:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vx6Eap2OuxsPf1499Uax7Ttsx2qtwc6VR8SU5LEnWZg=;
        b=mbDG7601/4RIHFoojAWqI526DMiK58Y/M+YdiuaDut6udaMy+ay0FsKAjXwwQZNGoR
         CCiCCX6q0Ifb0Es1FZmseu+4ptjuPexrchWATE6u8wRz9VCEwBt1M/uNqxojrZms3bG8
         0WLl1SXMxC222jmxUb4ac+b37ywVmzF4k4Bt06KEhQpKjNLnxcTQmb/rnpEP3cory9xL
         AyBmcgzM60l/VYfVNFfpdbziHG+NSYVni184IBH9Nzhl7KyBEv2SyFRoK+RRh7JlXWHY
         Kjbml6mMXpQYtkfwLV5W+NzTCarpw1jP2Bi+KDDfKRsMmsd+aq6DqxZeP4A7KZpVVm9d
         v+vA==
X-Gm-Message-State: AOAM533xW0Qo/cCauGCOD+T38qJIqaJnuj97HuMs9jKYlwxeC6FQpZtA
        fJn5FVFcnBsUIr2jpkp6NYAj4uGNS513QycVMl5K6WmnWxvZzXaPO22CtFUgGz4piLfSOf6+S2T
        eyNmep03TuM6bb4aekwaV
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr6199279wmj.172.1628184563786;
        Thu, 05 Aug 2021 10:29:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwmHpBEyQ42ianqozMIlYiVXLJH+NUXQprFquOC/W1fvzc6KeDbvs+MGzr+TSSp1k/vWSx7Q==
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr6199251wmj.172.1628184563522;
        Thu, 05 Aug 2021 10:29:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c630b.dip0.t-ipconnect.de. [91.12.99.11])
        by smtp.gmail.com with ESMTPSA id h25sm9508172wmp.33.2021.08.05.10.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:29:23 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210805170859.2389276-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <46998d10-d0ca-aeeb-8dcd-41b8130fb756@redhat.com>
Date:   Thu, 5 Aug 2021 19:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805170859.2389276-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05.08.21 19:08, Suren Baghdasaryan wrote:
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
> 
> After previous discussions [1, 2, 3] the decision was made [4] to introduce
> a dedicated system call to cover this use case.
> 
> The API is as follows,
> 
>            int process_mrelease(int pidfd, unsigned int flags);
> 
>          DESCRIPTION
>            The process_mrelease() system call is used to free the memory of
>            an exiting process.
> 
>            The pidfd selects the process referred to by the PID file
>            descriptor.
>            (See pidfd_open(2) for further information)
> 
>            The flags argument is reserved for future use; currently, this
>            argument must be specified as 0.
> 
>          RETURN VALUE
>            On success, process_mrelease() returns 0. On error, -1 is
>            returned and errno is set to indicate the error.
> 
>          ERRORS
>            EBADF  pidfd is not a valid PID file descriptor.
> 
>            EAGAIN Failed to release part of the address space.
> 
>            EINTR  The call was interrupted by a signal; see signal(7).
> 
>            EINVAL flags is not 0.
> 
>            EINVAL The memory of the task cannot be released because the
>                   process is not exiting, the address space is shared
>                   with another live process or there is a core dump in
>                   progress.
> 
>            ENOSYS This system call is not supported, for example, without
>                   MMU support built into Linux.
> 
>            ESRCH  The target process does not exist (i.e., it has terminated
>                   and been waited on).
> 
> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v7:
> - Fixed pidfd_open misspelling, per Andrew Morton
> - Fixed wrong task pinning after find_lock_task_mm() issue, per Michal Hocko
> - Moved MMF_OOM_SKIP check before task_will_free_mem(), per Michal Hocko
> 
>   mm/oom_kill.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c729a4c4a1ac..a4d917b43c73 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -28,6 +28,7 @@
>   #include <linux/sched/task.h>
>   #include <linux/sched/debug.h>
>   #include <linux/swap.h>
> +#include <linux/syscalls.h>
>   #include <linux/timex.h>
>   #include <linux/jiffies.h>
>   #include <linux/cpuset.h>
> @@ -1141,3 +1142,75 @@ void pagefault_out_of_memory(void)
>   	out_of_memory(&oc);
>   	mutex_unlock(&oom_lock);
>   }
> +
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	struct task_struct *p;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	long ret = 0;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +
> +	/*
> +	 * If the task is dying and in the process of releasing its memory
> +	 * then get its mm.
> +	 */
> +	p = find_lock_task_mm(task);
> +	if (!p) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +	if (task != p) {
> +		get_task_struct(p);


Wouldn't we want to obtain the mm from p ? I thought that was the whole 
exercise of going via find_lock_task_mm().

-- 
Thanks,

David / dhildenb

