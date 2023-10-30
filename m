Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D182F7DB5C3
	for <lists+linux-api@lfdr.de>; Mon, 30 Oct 2023 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJ3JHN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Oct 2023 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JHM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Oct 2023 05:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C02E6
        for <linux-api@vger.kernel.org>; Mon, 30 Oct 2023 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698656792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0atX0+sSSXblFLFWLmbV5ArNow5LoKvzRBMtZdLmQk=;
        b=AggfYkFE20GlBuawllO5ZB4I+LKFFFKPUq/NF+GXc8I5i5f9pi830IdWMZAtciqApXaA5m
        ea9OBsgIlQdJBUf0lRMJV6FOXrHfsSXQZbdPdUvowt4SptHRtcfKrvZuDoGQ8y2RERIHxI
        g3heZGPXu2M34kFdfexJwPBeSFAhmR0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-x9vaknFOO7eNi0xhrFuy7A-1; Mon, 30 Oct 2023 05:06:30 -0400
X-MC-Unique: x9vaknFOO7eNi0xhrFuy7A-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6b9af7d41c6so2922739b3a.0
        for <linux-api@vger.kernel.org>; Mon, 30 Oct 2023 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656789; x=1699261589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0atX0+sSSXblFLFWLmbV5ArNow5LoKvzRBMtZdLmQk=;
        b=N1n/U1ERVY7rTaQUQHpmmM7vh23Xy4LMAQqlXxipkoyMjO7JP0WBcOslor2d5PV+Li
         AP03cMsar1iI3fuySG/aBgK/kUn9hWb7BrFTXAOOqlR1WSzmoM5bEBrACUlilTi2ra50
         C6CXXEWA/yNkFGyB3+JiV4/MW04tCVaXPU/srawwMOvN0lm6jhuRx2ByaS7Z6z2C6Z5z
         bxzWezmm4PiuHyJ0mkmUQMkff+TvJRfsRDYn1pHdZk0ou+ZBw8wl3VAVcJVDlov7infU
         Yv1MKzt6yM7AdbaiO6msbK/IXdGW+7a0qvnNGRn7C/Ue5ZR++217yQtI+IG/cmcH+3TB
         /lbg==
X-Gm-Message-State: AOJu0YzZZF/3+y1tLdsxZpUTaiabIZUOBPbMDSoun0fN1l0Enya+no3G
        0AbxpGYIsgdwGOY4l2JDfsWu66RjRxa3+T5xsLgvVun3yPfEsnCtqUn+hf9Kcwjgyk9YT7xEcEc
        g2RfPP+s22bjNuKRGB+fVniWVVGwqVu/whIKo
X-Received: by 2002:a05:6a20:7d8a:b0:171:a8bc:74b2 with SMTP id v10-20020a056a207d8a00b00171a8bc74b2mr8574564pzj.7.1698656789551;
        Mon, 30 Oct 2023 02:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgI6VSfuoAE2RQro4OApKzTh51pBH7xn4E0oXjcNFufoZcmb5hUYyAZ9Iwz2uBJUgmSjdLrxau1bmihHZXQhg=
X-Received: by 2002:a05:6a20:7d8a:b0:171:a8bc:74b2 with SMTP id
 v10-20020a056a207d8a00b00171a8bc74b2mr8574537pzj.7.1698656789216; Mon, 30 Oct
 2023 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-3-mszeredi@redhat.com>
 <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net> <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
 <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net> <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
 <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
In-Reply-To: <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 30 Oct 2023 10:06:18 +0100
Message-ID: <CAOssrKdvTrPbnicFTiCiMNhKfdfwFEv4r_y1JeEe+H5V6LpkKg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
To:     Ian Kent <raven@themaw.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 30, 2023 at 6:45=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:

> Is fs/namespace.c:iterate_mounts() a problem?
>
> It's called from:
>
> 1) ./kernel/audit_tree.c:709: if (iterate_mounts(compare_root,
> 2) ./kernel/audit_tree.c:839:    err =3D iterate_mounts(tag_mount, tree, =
mnt);
> 3) ./kernel/audit_tree.c:917:        failed =3D iterate_mounts(tag_mount,
> tree, tagged);
>
>
>  From functions 1) audit_trim_trees(), 2) audit_add_tree_rule() and
>
> 3) audit_tag_tree().

So that interface works like this:

 - collect_mounts() creates a temporary copy of a mount tree, mounts
are chained on mnt_list.

 - iterate_mounts() is used to do some work on the temporary tree

 - drop_collected_mounts() frees the temporary tree

These mounts are never installed in a namespace.  My guess is that a
private copy is used instead of the original mount tree to prevent
races.

Thanks,
Miklos

