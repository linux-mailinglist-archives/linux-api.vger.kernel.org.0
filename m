Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3D11322
	for <lists+linux-api@lfdr.de>; Thu,  2 May 2019 08:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEBGIt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 May 2019 02:08:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41590 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfEBGIs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 May 2019 02:08:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so609382pfd.8;
        Wed, 01 May 2019 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WmtQTHpqD8h10ZK1NxAw5cdZrq5WyjBaKApCo1yE804=;
        b=Y7I8E/jv4MaKIw9Q6kOe0VW6Gp7vDzRRr6sx99FX6ovTaDd5JN+REGH6mPpGJgIjWr
         RBAknQmh57VGzd7bMlRxoLAWteR7LFQnzHT3vfAjGUtqJmR4O+b7nBpbUWDcsL9Qzt1d
         O9txtvOcBMih0U+oT6EVA/YqCKqw3z7/lFfwxrV+tD7HYRxBSthh5XZlJodfAvnV7W+A
         XXy88/9OEs3IkIME9wya2tzZFWk9JcNnpljG0FR3Je2ny1As2g40H4xFEq3AU5V70vEO
         eFDlmvEpZKWZBWHWfYirgypq/ShC0Zu6DSFSsX1gmjCE/0oRKwL8bs9onvC3HP2aSk5X
         KAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmtQTHpqD8h10ZK1NxAw5cdZrq5WyjBaKApCo1yE804=;
        b=UHr3neN4SS6DMdT5jToBeDdyUQRr0bDQ9XpCEXP98QAXMBQie1Vu8r1HNkjzqYxDVT
         YKR+NL9A8IHuLs0omoHFTjcycCUj2DXt+CB/dH1TpeMEiUVkP9B/x/DyeURSAK7Equd8
         EfpGAaBp8CGJ1FqZatc+SVJWF/cslrQpD0zOdEqPRGlMJnJ01YCrzB8x0NqkZG2b91Ni
         ltTml1Pownn1VLHaXEHPM68XrbTRdoeqDFu0oPmuB14MDovYpP0dFJZP4srP2U1WXDpm
         iOhicSIwEzzGeanjN5ehW5oBcHtZ8Kk85QUgN/nq9bYZzhUeOVdTjsi0cvBBZL+eMeQ1
         PXHw==
X-Gm-Message-State: APjAAAX9d2ll/ufPsvALhmEe57QljCB3bXjTow0AmQSVJJpv91AyPm1a
        JkCy+Se4E1QHOSQGyJHa6Zs=
X-Google-Smtp-Source: APXvYqyUqeL06JvMAGAtVCQXjFCn944o7wjsR+9BvTufEe9daCN/GlLCYU5ekfZ4t2FaoCUhwJP3iQ==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr2162000pgs.245.1556777326331;
        Wed, 01 May 2019 23:08:46 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id k9sm50059546pga.22.2019.05.01.23.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 23:08:45 -0700 (PDT)
Date:   Wed, 1 May 2019 23:08:43 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCHv3 19/27] timens/fs/proc: Introduce
 /proc/pid/timens_offsets
Message-ID: <20190502060842.GA4608@gmail.com>
References: <20190425161416.26600-1-dima@arista.com>
 <20190425161416.26600-20-dima@arista.com>
 <CAG48ez1ws9qXyNHfScY1RoajG=pquFe4y9QpM1c_xtPSeC2SNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAG48ez1ws9qXyNHfScY1RoajG=pquFe4y9QpM1c_xtPSeC2SNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jann,

Thank you for the review. Here are a few comments inline.

On Thu, Apr 25, 2019 at 08:16:41PM +0200, Jann Horn wrote:
> On Thu, Apr 25, 2019 at 6:15 PM Dmitry Safonov <dima@arista.com> wrote:
> > API to set time namespace offsets for children processes, i.e.:
> > echo "clockid off_ses off_nsec" > /proc/self/timens_offsets
> [...]
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 6a803a0b75df..76d58e9b5178 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> [...]
> > @@ -1521,6 +1522,103 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
> >
> >  #endif /* CONFIG_SCHED_AUTOGROUP */
> >
> > +#ifdef CONFIG_TIME_NS
> > +static int timens_offsets_show(struct seq_file *m, void *v)
> > +{
> > +       struct inode *inode = m->private;
> > +       struct task_struct *p;
> > +
> > +       p = get_proc_task(inode);
> 
> (FYI, this could also be "p = get_proc_task(file_inode(m->file));".
> But this works, too.)
> 
> > +       if (!p)
> > +               return -ESRCH;
> > +       proc_timens_show_offsets(p, m);
> > +
> > +       put_task_struct(p);
> > +
> > +       return 0;
> > +}
> > +
> > +static ssize_t
> > +timens_offsets_write(struct file *file, const char __user *buf,
> > +           size_t count, loff_t *ppos)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       struct proc_timens_offset offsets[2];
> > +       char *kbuf = NULL, *pos, *next_line;
> > +       struct task_struct *p;
> > +       int ret, noffsets;
> > +
> > +       /* Only allow < page size writes at the beginning of the file */
> > +       if ((*ppos != 0) || (count >= PAGE_SIZE))
> > +               return -EINVAL;
> > +
> > +       /* Slurp in the user data */
> > +       kbuf = memdup_user_nul(buf, count);
> > +       if (IS_ERR(kbuf))
> > +               return PTR_ERR(kbuf);
> > +
> > +       /* Parse the user data */
> > +       ret = -EINVAL;
> > +       noffsets = 0;
> > +       pos = kbuf;
> > +       for (; pos; pos = next_line) {
> > +               struct proc_timens_offset *off = &offsets[noffsets];
> > +               int err;
> > +
> > +               /* Find the end of line and ensure I don't look past it */
> > +               next_line = strchr(pos, '\n');
> > +               if (next_line) {
> > +                       *next_line = '\0';
> > +                       next_line++;
> > +                       if (*next_line == '\0')
> > +                               next_line = NULL;
> > +               }
> > +
> > +               err = sscanf(pos, "%u %lld %lu", &off->clockid,
> > +                               &off->val.tv_sec, &off->val.tv_nsec);
> > +               if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
> > +                       goto out;
> > +               if (noffsets++ == ARRAY_SIZE(offsets))
> > +                       break;
> 
> This is equivalent to:
> 
> if (noffsets == ARRAY_SIZE(offsets)) {
	  noffsets++;
>         break;
  }
> noffsets++;
> 
> So we can reach the start of the loop with
> noffsets==ARRAY_SIZE(offsets), right? Which means that an
> out-of-bounds write can happen?

good catch. I will add a test for this case.

> 
> I think that for code like this, it makes sense to write the increment
> and the check out separately so that it's easier to spot problems;
> e.g. like this:
> 
> noffsets++;
> if (noffsets == ARRAY_SIZE(offsets))
>         break;

will rewrite this way. Thanks!

> 
> > +       }
> > +
> > +       ret = -ESRCH;
> > +       p = get_proc_task(inode);
> > +       if (!p)
> > +               goto out;
> > +       ret = proc_timens_set_offset(p, offsets, noffsets);
> > +       put_task_struct(p);
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = count;
> > +out:
> > +       kfree(kbuf);
> > +       return ret;
> > +}
> > +
> > +static int timens_offsets_open(struct inode *inode, struct file *filp)
> > +{
> > +       int ret;
> > +
> > +       ret = single_open(filp, timens_offsets_show, NULL);
> > +       if (!ret) {
> > +               struct seq_file *m = filp->private_data;
> > +
> > +               m->private = inode;
> > +       }
> > +       return ret;
> > +}
> 
> Why did you write it like this? Wouldn't the following be equivalent?

Probably I looked at sched_autogroup_open

> 
> static int timens_offsets_open(struct inode *inode, struct file *file)
> {
>         return single_open(file, timens_offsets_show, inode);
> }
> 
> (But also, you can reach the inode of a seq_file as file_inode(m->file).)
> 
> [...]
> > diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
> > index e806accc4eaf..9ad4b63c4ed2 100644
> > --- a/kernel/time_namespace.c
> > +++ b/kernel/time_namespace.c
> [...]
> > +
> > +int proc_timens_set_offset(struct task_struct *p,
> > +                          struct proc_timens_offset *offsets, int noffsets)
> > +{
> > +       struct ns_common *ns;
> > +       struct time_namespace *time_ns;
> > +       struct timens_offsets *ns_offsets;
> > +       struct timespec64 *offset;
> > +       struct timespec64 tp;
> > +       int i, err;
> > +
> > +       ns = timens_for_children_get(p);
> > +       if (!ns)
> > +               return -ESRCH;
> > +       time_ns = to_time_ns(ns);
> > +
> > +       if (!time_ns->offsets || time_ns->initialized ||
> > +           !ns_capable(time_ns->user_ns, CAP_SYS_TIME)) {
> 
> Capability checks in VFS read/write handlers are bad. Please pass
> through the file pointer to this function and replace the call with
> "file_ns_capable(file, time_ns->user_ns, CAP_SYS_TIME)".

Will fix. Thanks!
> 
> > +               put_time_ns(time_ns);
> > +               return -EPERM;
> > +       }
> [...]
> > +}
