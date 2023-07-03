Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03A74574B
	for <lists+linux-api@lfdr.de>; Mon,  3 Jul 2023 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGCIYv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jul 2023 04:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGCIWx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jul 2023 04:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CAE61
        for <linux-api@vger.kernel.org>; Mon,  3 Jul 2023 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688372522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDniCynZ7+HhXvQAOCX57oK500g52Olq9GhoAqPPWUs=;
        b=Jrc6Oy3GtlK4EwrpUOPYoxhWSH5/fF0Vzs6StmVcH120J2xldn4E4FZzrPFGfYwSX6TOkK
        ZvH6zR/fH86ZLJ5eYMQONHEZmtlQrhxbjdm4BaWkcGGOqgO+XD6YFqoyLQcQGhFsroFWdL
        OoLzlQMBKSjEgEN9eaLCbhQ6JNPs7gQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-qSfHAEDhOWSW0xJ1gdyBAA-1; Mon, 03 Jul 2023 04:21:57 -0400
X-MC-Unique: qSfHAEDhOWSW0xJ1gdyBAA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-bfe92598ffaso4493767276.0
        for <linux-api@vger.kernel.org>; Mon, 03 Jul 2023 01:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372517; x=1690964517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDniCynZ7+HhXvQAOCX57oK500g52Olq9GhoAqPPWUs=;
        b=SWTU8g36UXihXiux6dNSrCxNSsbsvnBjifqc2HPrsF/rB2GxfJWAHO3eMTlS9m4LUR
         yLSlPpB9w3GolRQtldWUXr6hgwRMlhXvfguli9ALj9qIgT//o8KswaEp/kuzuHFzOyaE
         qKjro2jXwZTEPFaK7iNNCRdZfMEdMonpG9VS1atzeLH+VH4p72qufJPQPESlIDeL3/PN
         SjJiHJ0OpwWWoa4nVZGeimN+cWwtc9Q9vfEl4Y24MGZv7Zqdah5/mJ/bps11VIq8MhGS
         lBFIDSre/dBP+gqRZjlvPjJtJbl/3bQVRgBad5IG62Z15ihMQxmvCh1wDUkMwzFW1Za8
         TuIA==
X-Gm-Message-State: ABy/qLbVudspEP8Sj5cTfWxCZ1rwAtCeJNOhbVAqzyztYy/bIJ6529/T
        zW2RAwG8KnUKeT/8X138U0GaKTOVRYi48kXoAVbeqwHuiUwRsvSJMQY0+VqYh9hO7I7YieAbnkA
        9Q1IM3k1IFlbzFyot7wU5LTybDH5y6j0xcdte
X-Received: by 2002:a25:21d5:0:b0:c39:e0f5:8616 with SMTP id h204-20020a2521d5000000b00c39e0f58616mr8210951ybh.46.1688372517229;
        Mon, 03 Jul 2023 01:21:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDI1TQ4yNBXhXRy2Ls9tZMeCzZCw/5NxW05oDphDYt6dbi8koo6BBkhcCkUZtgb7JdeBJbNiY37ga/25hmyqw=
X-Received: by 2002:a25:21d5:0:b0:c39:e0f5:8616 with SMTP id
 h204-20020a2521d5000000b00c39e0f58616mr8210946ybh.46.1688372516994; Mon, 03
 Jul 2023 01:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230609092127.170673-1-eperezma@redhat.com> <20230609092127.170673-3-eperezma@redhat.com>
 <20230609121244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230609121244-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 3 Jul 2023 10:21:20 +0200
Message-ID: <CAJaqyWcaLe6TX4VuqMkh_po=C17MVX-tVq-XqHkMWYLTXh-sHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
 backend feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
        Lei Yang <leiyang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, linux-api@vger.kernel.org,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        Shannon Nelson <snelson@pensando.io>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
        Harpreet Singh Anand <hanand@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 9, 2023 at 6:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Jun 09, 2023 at 11:21:25AM +0200, Eugenio P=C3=A9rez wrote:
> > Accepting VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature if
> > userland sets it.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Acked-by: Shannon Nelson <shannon.nelson@amd.com>
>
> I don't get it, so all vdpa devices accept this automatically?
> Should this not be up to the parent?
>

At the moment I don't see a reason why if a parent offers this
feature, it could reject it afterwards. However I think we can add a
fail if userland acks the backend feature but the parent does not
offer it however.

Would it work to add such fail in vdpa frontend and move it to the
backend if and when any parent driver needs it in the future?

Thanks!

> > ---
> >  drivers/vhost/vdpa.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index bf77924d5b60..a3204406b73d 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -680,7 +680,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
> >                       return -EFAULT;
> >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > -                              BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > +                              BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > +                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> >                       return -EOPNOTSUPP;
> >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> >                    !vhost_vdpa_can_suspend(v))
> > --
> > 2.31.1
>

