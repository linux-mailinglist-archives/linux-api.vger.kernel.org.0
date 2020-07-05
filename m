Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C08214D79
	for <lists+linux-api@lfdr.de>; Sun,  5 Jul 2020 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgGEPLZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 5 Jul 2020 11:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGEPLY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 5 Jul 2020 11:11:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A6C061794
        for <linux-api@vger.kernel.org>; Sun,  5 Jul 2020 08:11:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f12so13549577eja.9
        for <linux-api@vger.kernel.org>; Sun, 05 Jul 2020 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=Hbpzh2mkywq3PINoKnKvIeWREaFlJ3B37cTwpnx5RerTgpbuKhSZPwrsl1vLicqVxn
         ppPB4hWBeYerbw9BThTxK+n8qqf2CdjU6s1IapyqlR2OMNy+nRTlEXRsvO55prOmzSfR
         GdJuNL11UHoSywYCM3N0fE+L0KDjyeW5bA0QLIHmCIHZMOCWUhHXaRZ43bxKjdjMI7bD
         l+lzN56NXJzBqSPgPsICGEuAOksqaFb7tK3H4T7GjSYbz1pnMTuBMKKgASJ99mLUoqmU
         dkZrcvT0qaRaKCHuU/YsajwEu9OLxgMbwVVylVTd94Q+LxGxTmDXntTiK6+kU/1BOiQp
         yhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=c5B/IJvJka4VHN41FV83iOsmJ9Ml0EjStkPFnP2gW8Nf37kQhUdeYEvsvbHmuo42nd
         b8UjOvB+d5SvdKtiWthdV7Io83RW+9CfA2AzjLVr4XwOrdti3+kL2F2k7KJklJnmmJz+
         LrJ/M/9YtnsBm/EOdjYRtW39fYxvktbPoibnfeolBTeEiMC2c8hWct6CwzQBd16ftv7u
         gKFHW9dw5URiCMV/dh/obX0r36C5teLwtHUJuzSwjiBnJ/FLFSAN89FCnWHvkdmK3ih7
         lov/0sgpBBtFp1U/8dWQAFQ4tmNinmJWPJ4xAxhYLv8kgbgV43jh3whzAQM4YQP9NKa9
         3VkQ==
X-Gm-Message-State: AOAM533jqh7HBNW0LiWSHxgndIZCAxg2O6l7KAgj4XxAE6kZkz65CMFE
        fkt8JFSekzxw/ujEdjnuSU8rdIDx3O4spqcQPYk1YNM=
X-Google-Smtp-Source: ABdhPJykYYlS6DyRXswVmWtbu7A3Q6Dy8mVKkx1CmIV5P5PACrs0bkv1logTfFs6fMkOIf3NdUb1tBevQz1LKf/qCoI=
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr36448175ejb.488.1593961882949;
 Sun, 05 Jul 2020 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
In-Reply-To: <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:11:11 -0400
Message-ID: <CAHC9VhSwMEZrq0dnaXmPi=bu0NgUtWPuw-2UGDrQa6TwxWkZtw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 08/13] audit: add containerid support for user records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 27, 2020 at 9:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add audit container identifier auxiliary record to user event standalone
> records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/audit.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 54dd2cb69402..997c34178ee8 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1507,6 +1504,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 audit_log_n_untrustedstring(ab, str, data_len);
>                         }
>                         audit_log_end(ab);
> +                       rcu_read_lock();
> +                       cont = _audit_contobj_get(current);
> +                       rcu_read_unlock();
> +                       audit_log_container_id(context, cont);
> +                       rcu_read_lock();
> +                       _audit_contobj_put(cont);
> +                       rcu_read_unlock();
> +                       audit_free_context(context);

I haven't searched the entire patchset, but it seems like the pattern
above happens a couple of times in this patchset, yes?  If so would it
make sense to wrap the above get/log/put in a helper function?

Not a big deal either way, I'm pretty neutral on it at this point in
the patchset but thought it might be worth mentioning in case you
noticed the same and were on the fence.

--
paul moore
www.paul-moore.com
