Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4140E11504D
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 13:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLFMXW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 07:23:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbfLFMXW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 07:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575635001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Qqh0TAEbm3CujH7YteZT0zbdmoeyevvShd6mToTqps=;
        b=fJ/65sIbUtFwp04tW9LogA2UxV5gX4IwHGmM/bsc7AeVbKeGjGzXU6mkSy1/wuJKSltQ1o
        6Emeq/w0kmyfwRE6kKZnPeeX5bd87B+V7FkOuerb5d+loZQ8lD0umIYYq6khqsuUnowAqY
        2/0/jLAQ3rqY3d7iZI5WaBV1Asy0FAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-vaddTg2kPsutelJz7_iIYA-1; Fri, 06 Dec 2019 07:23:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F15107ACC9;
        Fri,  6 Dec 2019 12:23:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 510A610018FF;
        Fri,  6 Dec 2019 12:23:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  6 Dec 2019 13:23:13 +0100 (CET)
Date:   Fri, 6 Dec 2019 13:23:11 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
Message-ID: <20191206122311.GA820@redhat.com>
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
 <20191206082539.gmefytwu3ylixj5d@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191206082539.gmefytwu3ylixj5d@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vaddTg2kPsutelJz7_iIYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
>
> > +static int ptrace_getfd(struct task_struct *child, unsigned long fd)
> > +{
> > +=09struct files_struct *files;
> > +=09struct file *file;
> > +=09int ret =3D 0;
> > +
> > +=09files =3D get_files_struct(child);
> > +=09if (!files)
> > +=09=09return -ENOENT;
> > +
> > +=09spin_lock(&files->file_lock);
> > +=09file =3D fcheck_files(files, fd);
> > +=09if (!file)
> > +=09=09ret =3D -EBADF;
> > +=09else
> > +=09=09get_file(file);
> > +=09spin_unlock(&files->file_lock);
> > +=09put_files_struct(files);

may be someone can finally create a helper for this, it can have more users=
.
say,
=09struct file *get_task_file(task, fd)
=09{
=09=09struct file *file =3D NULL;

=09=09task_lock(task);
=09=09rcu_read_lock();
=09=09if (task->files) {
=09=09=09file =3D fcheck_files(task->files, fd);
=09=09=09if (file)
=09=09=09=09get_file(file);
=09=09}
=09=09rcu_read_unlock();
=09=09task_unlock(task);

=09=09return file;
=09}


no need to get/put files_struct, no need to take ->file_lock.

> > +
> > +=09if (ret)
> > +=09=09goto out;
> > +
> > +=09ret =3D get_unused_fd_flags(0);
> > +=09if (ret >=3D 0)
> > +=09=09fd_install(ret, file);
> > +
> > +=09fput(file);

this looks wrong or I am totally confused...

=09if (ret >=3D 0)
=09=09fd_install(file);
=09else
=09=09fput(file);

?

> > @@ -1265,7 +1299,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid,=
 unsigned long, addr,
> >  =09}
> > =20
> >  =09ret =3D ptrace_check_attach(child, request =3D=3D PTRACE_KILL ||
> > -=09=09=09=09  request =3D=3D PTRACE_INTERRUPT);
> > +=09=09=09=09  request =3D=3D PTRACE_INTERRUPT ||
> > +=09=09=09=09  request =3D=3D PTRACE_GETFD);

Hmm. not sure why do you want this... But OK, we do not need to stop the tr=
acee.

Oleg.

