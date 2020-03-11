Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C58182199
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2020 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgCKTKV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Mar 2020 15:10:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37549 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgCKTKV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Mar 2020 15:10:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id p14so1869980pfn.4
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2020 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KcVIrCgeM2L71oQ0HCuZKZl5I3Zr+0M/E39SQWV0gp4=;
        b=aAhh+xSkXE2t12sKK6saJVYSmf5MEARRfmtM9BDdPnG9hOhY9hMiwRX70zMMhmadP8
         AEe0v12Bn33gajUeD1uQ8UKiOyi2zoq7FIlGGcSTWYQXUe84sEe6lGBVcgqvS8yfdCxA
         BqGVlEbMZdiVCE8GlL7i8viPdEpQyi+6TSziw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KcVIrCgeM2L71oQ0HCuZKZl5I3Zr+0M/E39SQWV0gp4=;
        b=pXDsQh4P7guuyq++iy8xq9qQVz5fF+w1bphIDTdHO9NqeQ2ygNVw2hWwElKuL/Iob3
         ung6Zes2E11QedHsFpUfOlqN1Hvd14EhiQN9Xs0/zT63nHh3KjajeN6mF1oATBHP5Kk1
         01CaLosVMCg5QHA1uGWGf7K28sznyt0XTzNP8fWheb0v4Yos8OnXBuhEbAx8rwq8hIrt
         qabkql5AWR6reuPNH9V5X11hLw9/fZFTFt0+gpV/R1PX/HbIha36zz9ohQeJ9Nq2aR9S
         QkbxGP50KvfomQ8alHsKb1RkRYQwaBa3yE1QVLlzhfr5Ly05dkjQXZqcBNq64siYllLh
         hIlA==
X-Gm-Message-State: ANhLgQ1Er79GmFL/SqgO4LVsoW4SdCjaU469+C4fxxGTcTHp/lj5DNa2
        3NoiypebXS1zEr/aHs/lIe73yg==
X-Google-Smtp-Source: ADFU+vt4NOtfCQB7oRTvrmQkPz4WbsEGCcbOLVTPV1BJcvkD6Dr4oGu+cuFqlafAZoPG2TJB9TQ2XQ==
X-Received: by 2002:aa7:8687:: with SMTP id d7mr4225994pfo.247.1583953820089;
        Wed, 11 Mar 2020 12:10:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e10sm9854448pfm.121.2020.03.11.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:10:19 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:10:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/4] proc: Use new infrastructure to fix deadlocks in
 execve
Message-ID: <202003111208.640025F75@keescook>
References: <87r1y12yc7.fsf@x220.int.ebiederm.org>
 <87k13t2xpd.fsf@x220.int.ebiederm.org>
 <87d09l2x5n.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170F0F9DC18F5EA77C9A857E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rq12vxu.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170DF45E3245F55B95CCD91E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <877dzt1fnf.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51701C6F60699F99C5C67E0BE4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <875zfcxlwy.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51705D211EC8E7EA270627B1E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB51705D211EC8E7EA270627B1E4FF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 10, 2020 at 06:45:32PM +0100, Bernd Edlinger wrote:
> This changes lock_trace to use the new exec_update_mutex
> instead of cred_guard_mutex.
> 
> This fixes possible deadlocks when the trace is accessing
> /proc/$pid/stack for instance.
> 
> This should be safe, as the credentials are only used for reading,
> and task->mm is updated on execve under the new exec_update_mutex.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

I have the same question here as in 3/4. I should probably rescind my
Reviewed-by until I'm convinced about the security-safety of this -- why
is this not a race against cred changes?

-Kees

> ---
>  fs/proc/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea950..4fdfe4f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -403,11 +403,11 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  
>  static int lock_trace(struct task_struct *task)
>  {
> -	int err = mutex_lock_killable(&task->signal->cred_guard_mutex);
> +	int err = mutex_lock_killable(&task->signal->exec_update_mutex);
>  	if (err)
>  		return err;
>  	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_FSCREDS)) {
> -		mutex_unlock(&task->signal->cred_guard_mutex);
> +		mutex_unlock(&task->signal->exec_update_mutex);
>  		return -EPERM;
>  	}
>  	return 0;
> @@ -415,7 +415,7 @@ static int lock_trace(struct task_struct *task)
>  
>  static void unlock_trace(struct task_struct *task)
>  {
> -	mutex_unlock(&task->signal->cred_guard_mutex);
> +	mutex_unlock(&task->signal->exec_update_mutex);
>  }
>  
>  #ifdef CONFIG_STACKTRACE
> -- 
> 1.9.1

-- 
Kees Cook
