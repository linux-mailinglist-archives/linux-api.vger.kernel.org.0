Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4C15B5CE
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 01:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgBMAZe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 19:25:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:9911 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBMAZd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 12 Feb 2020 19:25:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 16:25:33 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="380936140"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 16:25:31 -0800
Message-ID: <6bb20b3d4e3362337e1a4c8a4be13f6acda5b0ec.camel@linux.intel.com>
Subject: Re: [PATCH v4 7/8] pid: export pidfd_get_pid
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Date:   Wed, 12 Feb 2020 16:25:31 -0800
In-Reply-To: <20200212233946.246210-8-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
         <20200212233946.246210-8-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 2020-02-12 at 15:39 -0800, Minchan Kim wrote:
> process_madvise syscall needs pidfd_get_pid function to translate
> pidfd to pid so this patch exports the function.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

I think you might have misunderstood my earlier comments. This should be
patch 2 in your set. What is patch 8 should be folded into you existing
patch 2 and become patch 3 with the rest of your patches shifted by 1
since you are reordering them.

Otherwise the code itself appears to not have changed anything so it looks
fine to me.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  include/linux/pid.h |  1 +
>  kernel/exit.c       | 17 -----------------
>  kernel/pid.c        | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 998ae7d24450..023d9c3a8edc 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
>  struct file;
>  
>  extern struct pid *pidfd_pid(const struct file *file);
> +extern struct pid *pidfd_get_pid(unsigned int fd);
>  
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0b81b26a872a..43375f9d8bbc 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1470,23 +1470,6 @@ static long do_wait(struct wait_opts *wo)
>  	return retval;
>  }
>  
> -static struct pid *pidfd_get_pid(unsigned int fd)
> -{
> -	struct fd f;
> -	struct pid *pid;
> -
> -	f = fdget(fd);
> -	if (!f.file)
> -		return ERR_PTR(-EBADF);
> -
> -	pid = pidfd_pid(f.file);
> -	if (!IS_ERR(pid))
> -		get_pid(pid);
> -
> -	fdput(f);
> -	return pid;
> -}
> -
>  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>  			  int options, struct rusage *ru)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0f4ecb57214c..360ba480a2a9 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -496,6 +496,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>  	return idr_get_next(&ns->idr, &nr);
>  }
>  
> +struct pid *pidfd_get_pid(unsigned int fd)
> +{
> +	struct fd f;
> +	struct pid *pid;
> +
> +	f = fdget(fd);
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +
> +	pid = pidfd_pid(f.file);
> +	if (!IS_ERR(pid))
> +		get_pid(pid);
> +
> +	fdput(f);
> +	return pid;
> +}
> +
>  /**
>   * pidfd_create() - Create a new pid file descriptor.
>   *


