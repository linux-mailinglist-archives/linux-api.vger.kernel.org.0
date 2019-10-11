Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2CD3645
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 02:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfJKAjs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 20:39:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44697 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfJKAjs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 20:39:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id q12so5720282lfc.11
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N487as+c+FNQH8UKaT6HaOwU2u0KpBH93Y19zrHfpEU=;
        b=ufwcAAv+UFt3XUw6Rd8NAzS51flGDXx3ywuA5XIH5+S2oFoO1Eaf6UmFdjOUMI6gka
         6yCyta6ksoQrqSOl/4+hkHsG2c7boYbSkNyYM6xN8dBIPbyC96ggLQiwD1//Cssn99Rv
         66i8F1CDFiyrlz+9H6hdBO4lrbiRgJ+nzfIONCUyXnWD2+c1GE1f7j8L2AMRZBEfy9g5
         ZZYXTCvADd7l7/9pzVM3B1yUR1VRIxbYY8Yzx/B6+8NzIhME/H8YnuE2Mh06ykvkFBst
         ktCU1ig6EE3fVh6p9t8PnxmUOgUALw4WIVCUzgXCP7JYSSNw42EzsQ/ca4pdqBnSXpKU
         7bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N487as+c+FNQH8UKaT6HaOwU2u0KpBH93Y19zrHfpEU=;
        b=kNf6e8SFCjOtAeNz79dGTD7bZybCb0DJvcRjb5NIxpNVo3dsmJNRPRw/25mBGr2/8W
         tr+94ekxkYe9o7v1my4zKLrnZmv0hndXYN4BKUoKdcWhEdtD/D9MQHHKRrif0fLWJ7GB
         PmjQMNpcQpD/+q+3fxAaFAEZA7KKQ0xTi5WYUNL4Rd/SAxW0ICIzEPuB00mztVWqosvJ
         WrsiaaYlG/klm+0+jy+4+lsa5tP7NYYzzFjY6jGclC0wk50aYZSFxUPN24AmkdE7YQi1
         IdJXF6aQzs4YZ1U5Z0kTYjuGrj4z8/OTdkZem0U+fKkI/3LmaLeMj8R3CUqSB2QcA8Kx
         LsyQ==
X-Gm-Message-State: APjAAAUbFfpGGnsP/93lp/guzAXFYfQtGWtm/gOueCjt8xQFo6kMJvJn
        ns9pLH6vC7cjGP27+hv7zFtFr/kBFw02tZoCqxW/
X-Google-Smtp-Source: APXvYqyB4RJDQCQWsrtqXfnRzChlUNiZfRjoEHOyfVUdO0CSjjh+KCjiX6b5mwIZ8VzpJPbiupVbYYs83JZ7LdEfTCQ=
X-Received: by 2002:a19:2394:: with SMTP id j142mr7362655lfj.13.1570754386530;
 Thu, 10 Oct 2019 17:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <91315ac64b44bcad9dfc623fa7fefe67d7d2561b.1568834524.git.rgb@redhat.com>
In-Reply-To: <91315ac64b44bcad9dfc623fa7fefe67d7d2561b.1568834524.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:39:35 -0400
Message-ID: <CAHC9VhRgOTfZzzv+NxxH3D3FN-2A=cd2h1+oDc2cabLhzi4gfQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 12/21] audit: add support for containerid to
 network namespaces
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit events could happen in a network namespace outside of a task
> context due to packets received from the net that trigger an auditing
> rule prior to being associated with a running task.  The network
> namespace could be in use by multiple containers by association to the
> tasks in that network namespace.  We still want a way to attribute
> these events to any potential containers.  Keep a list per network
> namespace to track these audit container identifiiers.
>
> Add/increment the audit container identifier on:
> - initial setting of the audit container identifier via /proc
> - clone/fork call that inherits an audit container identifier
> - unshare call that inherits an audit container identifier
> - setns call that inherits an audit container identifier
> Delete/decrement the audit container identifier on:
> - an inherited audit container identifier dropped when child set
> - process exit
> - unshare call that drops a net namespace
> - setns call that drops a net namespace
>
> Please see the github audit kernel issue for contid net support:
>   https://github.com/linux-audit/audit-kernel/issues/92
> Please see the github audit testsuiite issue for the test case:
>   https://github.com/linux-audit/audit-testsuite/issues/64
> Please see the github audit wiki for the feature overview:
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h | 19 +++++++++++
>  kernel/audit.c        | 87 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/nsproxy.c      |  4 +++
>  3 files changed, 108 insertions(+), 2 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7cdb76b38966..e0c27bc39925 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -373,6 +381,75 @@ static struct sock *audit_get_sk(const struct net *net)
>         return aunet->sk;
>  }
>
> +void audit_netns_contid_add(struct net *net, u64 contid)
> +{
> +       struct audit_net *aunet;
> +       struct list_head *contid_list;
> +       struct audit_contid *cont;
> +
> +       if (!net)
> +               return;
> +       if (!audit_contid_valid(contid))
> +               return;
> +       aunet = net_generic(net, audit_net_id);
> +       if (!aunet)
> +               return;
> +       contid_list = &aunet->contid_list;
> +       spin_lock(&aunet->contid_list_lock);
> +       list_for_each_entry_rcu(cont, contid_list, list)
> +               if (cont->id == contid) {
> +                       refcount_inc(&cont->refcount);
> +                       goto out;
> +               }
> +       cont = kmalloc(sizeof(struct audit_contid), GFP_ATOMIC);

 kmalloc(sizeof(*cont), GFP_ATOMIC)


> +       if (cont) {
> +               INIT_LIST_HEAD(&cont->list);
> +               cont->id = contid;
> +               refcount_set(&cont->refcount, 1);
> +               list_add_rcu(&cont->list, contid_list);
> +       }
> +out:
> +       spin_unlock(&aunet->contid_list_lock);
> +}

--
paul moore
www.paul-moore.com
