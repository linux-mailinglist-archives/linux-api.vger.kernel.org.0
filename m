Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E930B3DE775
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhHCHsX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 03:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbhHCHsX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Aug 2021 03:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627976892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Cz4mJEVmDGl8yNoZ79kAMw4n8tDskkf0Kql/Sbl+6U=;
        b=fM2xMnNNT532d5i+NEFsGIbGI66fE7kcS4hLJFcmnyNeTU59imtDBvWaFVhazFSZz4+7JP
        HNVVjvBd7fLQrhXJwjoWGjuE8QfRI0qY+jPpOsUyoAyuBKN+45coNkuLbUTwkkYZnax/aF
        bikSSWfRbEYn69KV4fb4PPBV2rm3fPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-h7snX2xwMievGniz0gPOnA-1; Tue, 03 Aug 2021 03:48:11 -0400
X-MC-Unique: h7snX2xwMievGniz0gPOnA-1
Received: by mail-wm1-f72.google.com with SMTP id a197-20020a1c98ce0000b029025831695a2eso2810189wme.4
        for <linux-api@vger.kernel.org>; Tue, 03 Aug 2021 00:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7Cz4mJEVmDGl8yNoZ79kAMw4n8tDskkf0Kql/Sbl+6U=;
        b=QqjePfnsX2vujkstbn7P4queD/s/cKwY1ytglgallb1toV23kn3oNByIkNMR4hw/zg
         /ST4lJGSZvqWkyT2wvjXbFqPOt3LunlTkr/ZStZPsKs7t9YaH+jZ3b/F2ZAwJv8HPnA6
         cw0CXFnW4XdOwkUf+b4hUMOJ/JsMZx8iooEeF2gO0Krfl3KJAvah0YurbI0ZUAjfI1n5
         HAPtTdYLZYpsE5NG5BfBCkdvVQWnuzyFkOBKuVfvitD8JoWvK0QkIsdc96HALL3owhGz
         H7136W+HlrqKqsXUbkHtPjQticzIoAzVb8QoDdf82rn9eWAPGsr6+bK8bUDQjoZ+yU7V
         LeNA==
X-Gm-Message-State: AOAM533R7G/fyEPEJFjWIsw2l8aowv0YsOv25XjArCBlpE2tHTqlOd6v
        343gDluUFW/Y6+Fb4IAu28oZsZ0lBli3UQfc31qNoVqGQvMRogaBipD4FsVXjrFAKLJZ3PD0xTN
        UWG5nxIhCcs8fQnhRyMpv
X-Received: by 2002:adf:f704:: with SMTP id r4mr22002792wrp.389.1627976889765;
        Tue, 03 Aug 2021 00:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxowVVNUa0hycw1XWUzEd3fE+9kjYSa2132/0hwpvRvMe/A28XCQeByi13QdPkqhfgifHYRrg==
X-Received: by 2002:adf:f704:: with SMTP id r4mr22002758wrp.389.1627976889502;
        Tue, 03 Aug 2021 00:48:09 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23a79.dip0.t-ipconnect.de. [79.242.58.121])
        by smtp.gmail.com with ESMTPSA id z12sm12229644wml.18.2021.08.03.00.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:48:09 -0700 (PDT)
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210802221431.2251210-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/2] mm: introduce process_mrelease system call
Message-ID: <95eff329-a7b1-dc2d-026c-fd61e476c846@redhat.com>
Date:   Tue, 3 Aug 2021 09:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802221431.2251210-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[...]

> Previously I proposed a number of alternatives to accomplish this:
> - https://lore.kernel.org/patchwork/patch/1060407 extending

I have no idea how stable these links are. Referencing via message id is 
the common practice. For this link, we'd use

https://lkml.kernel.org/r/20190411014353.113252-3-surenb@google.com/

instead.

> pidfd_send_signal to allow memory reaping using oom_reaper thread;
> - https://lore.kernel.org/patchwork/patch/1338196 extending
> pidfd_send_signal to reap memory of the target process synchronously from
> the context of the caller;
> - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> support for process_madvise implementing synchronous memory reaping.
> 
> The end of the last discussion culminated with suggestion to introduce a
> dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> The reasoning was that the new variant of process_madvise
>    a) does not work on an address range
>    b) is destructive
>    c) doesn't share much code at all with the rest of process_madvise
>  From the userspace point of view it was awkward and inconvenient to provide
> memory range for this operation that operates on the entire address space.
> Using special flags or address values to specify the entire address space
> was too hacky.

I'd condense this description and only reference previous discussions to 
put a main focus on what this patch actually does. Like

"
After previous discussions [1, 2, 3] the decision was made to introduce 
a dedicated system call to cover this use case.

...

[1] https://lkml.kernel.org/r/20190411014353.113252-3-surenb@google.com/
"

> 
> The API is as follows,
> 
>            int process_mrelease(int pidfd, unsigned int flags);
> 
>          DESCRIPTION
>            The process_mrelease() system call is used to free the memory of
>            a process which was sent a SIGKILL signal.
> 
>            The pidfd selects the process referred to by the PID file
>            descriptor.
>            (See pidofd_open(2) for further information)
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
>            EINVAL The task does not have a pending SIGKILL or its memory is
>                   shared with another process with no pending SIGKILL.

Hm, I do wonder if it would make sense to have a mode (e.g., via a flag) 
to reap all but shared memory from a dying process. Future work.

> 
>            ENOSYS This system call is not supported by kernels built with no
>                   MMU support (CONFIG_MMU=n).

Maybe "This system call is not supported, for example, without MMU 
support built into Linux."

> 
>            ESRCH  The target process does not exist (i.e., it has terminated
>                   and been waited on).
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v4:
> - Replaced mmap_read_lock() with mmap_read_lock_killable(), per Michal Hocko
> - Added EINTR error in the manual pages documentation
> 
>   mm/oom_kill.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c729a4c4a1ac..86727794b0a8 100644
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
> @@ -1141,3 +1142,60 @@ void pagefault_out_of_memory(void)
>   	out_of_memory(&oc);
>   	mutex_unlock(&oom_lock);
>   }
> +
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	long ret = 0;
> +
> +	if (flags != 0)

if (flags)

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
> +	task_lock(task);
> +	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> +		mm = task->mm;
> +		mmget(mm);
> +	}
> +	task_unlock(task);
> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto put_task;
> +	}
> +
> +	if (mmap_read_lock_killable(mm)) {
> +		ret = -EINTR;
> +		goto put_mm;
> +	}
> +	if (!__oom_reap_task_mm(mm))
> +		ret = -EAGAIN;

I'm not an expert on __oom_reap_task_mm(), but the whole approach makes 
sense to. So feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

