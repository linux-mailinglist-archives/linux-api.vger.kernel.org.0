Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890257DE187
	for <lists+linux-api@lfdr.de>; Wed,  1 Nov 2023 14:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjKANT1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Nov 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjKANT0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Nov 2023 09:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19450103
        for <linux-api@vger.kernel.org>; Wed,  1 Nov 2023 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698844724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSv2DzNgtmTMp0Zpn8vNNj88K76tIu0ml3mAsMedefM=;
        b=O2CcS3uDlW1j9n74KpOzUPUxQ9WvgsNI61kzL/BPSIs7Stv7GxrjOIT/eMMBw8jcYElnsX
        AyJ+Sw24h19PDOhAN2vwvtl/w6NneFyw1+fdZisUbtDYxEZslCZHI/x4pTEy3bBjvvUpG1
        AyB3lY/iuoaZ0wddngZ23du29X19O78=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ME3lpL8QN0KcpoOx8H7W7Q-1; Wed, 01 Nov 2023 09:18:43 -0400
X-MC-Unique: ME3lpL8QN0KcpoOx8H7W7Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-280152efdefso3658214a91.0
        for <linux-api@vger.kernel.org>; Wed, 01 Nov 2023 06:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698844722; x=1699449522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSv2DzNgtmTMp0Zpn8vNNj88K76tIu0ml3mAsMedefM=;
        b=CxCvcuCEDNx6SYbusVB7aYAF5dME4Rk0k+ZDHsQ3O8m9uHsetUzeHU9pOIZajWtGSM
         /k9urOC4s0dlkYl/9ftt/wa5F6L+owSQWS84tfc4ZN6/Q+1jkM+VEIWoOrBeKQafe17C
         f+8/rUwdJGQG9TvjhDCwNjlemOyU+M20DeiKT6kGjoBpODDvyNbAx7GaLqdqnAhtw3qX
         8UIzsYoJR9evgdnnTs3isYhxWNyJJ9WM5rOseUI+UYxyUfPYEKDolk5B5f6mXVve2SQd
         ibhvtFz1jhsu++ehqkNo9EmLgFETyB6/20Hfznkp19Ls3nlXz/hJ2bZ9sM8HIPz2qXYO
         y4Yw==
X-Gm-Message-State: AOJu0YzexBNRdj+mH6Wa9pclGlZpSanQH0U1UvxOSjnHDMDIGQ1gAfax
        dzE6ltUq9k/rkRfDSp40qdmxL7/vtjM3rXl0V9SL9ZK6sKF0z4OFduE/9riMH5NtdIpG3ia/+Jl
        whmYIW/uFkt3vh7GlXVPunudYn+aprfcHIKjo
X-Received: by 2002:a17:90b:23c7:b0:280:1dca:f6a3 with SMTP id md7-20020a17090b23c700b002801dcaf6a3mr10441091pjb.43.1698844722047;
        Wed, 01 Nov 2023 06:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEirGTDasAqUjXQGnKlAtyrPulCGVMINuDBdc2ZYq9ZRuzlBBKwBLe80AwfvqXtV4VYiPlMQ+XXMQ63Z1BoA=
X-Received: by 2002:a17:90b:23c7:b0:280:1dca:f6a3 with SMTP id
 md7-20020a17090b23c700b002801dcaf6a3mr10441056pjb.43.1698844721642; Wed, 01
 Nov 2023 06:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231101-urenkel-banal-b232d7a3cbe8@brauner>
In-Reply-To: <20231101-urenkel-banal-b232d7a3cbe8@brauner>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 1 Nov 2023 14:18:30 +0100
Message-ID: <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] querying mount attributes
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 1, 2023 at 12:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:

> I've renamed struct statmnt to struct statmount to align with statx()
> and struct statx. I also renamed struct stmt_state to struct kstatmount
> as that's how we usually do this. And I renamed struct __mount_arg to
> struct mnt_id_req and dropped the comment. Libraries can expose this in
> whatever form they want but we'll also have direct consumers. I'd rather
> have this struct be underscore free and officially sanctioned.

Thanks.

arch/arm64/include/asm/unistd.h needs this fixup:

-#define __NR_compat_syscalls 457
+#define __NR_compat_syscalls 459

Can you fix inline, or should I send a proper patch?

Thanks,
Miklos

