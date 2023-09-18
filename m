Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DC7A4C20
	for <lists+linux-api@lfdr.de>; Mon, 18 Sep 2023 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjIRP0p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Sep 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjIRP0o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Sep 2023 11:26:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE019B1
        for <linux-api@vger.kernel.org>; Mon, 18 Sep 2023 08:24:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso28664335e9.2
        for <linux-api@vger.kernel.org>; Mon, 18 Sep 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695050549; x=1695655349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=GwScA6Ke6lw9RmvkHS5GWMsNB3kRqjN1HLs1bLbj61JclWrd+BJgUtN1mnvak4j6p8
         P+1ooDPrcq/aaZkhnISvb56bymAYW7KpU2NGkUK0dWNcuEt7EzAisuUmjXPh+YJ7Xx3l
         gCkLuBsjgj9PBR6sgqWN+OgUd7Bgrxi8FtkaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050549; x=1695655349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=XDXjsWiNniFPoXWIIIKjZJATGJUH8yBI5U7O0KESZKo8AxcTv2srusdfzHm1dMn01V
         JhbX7ILBYWALKf3oTbjP9+THrDbvqa3eu7eSNcevBxG3tow+H1Rs0a6+LMjuPFLAwNMo
         DU9V0HtD0enkIen93sn07UPVmEPkjXuGBrzf2oyt66b6vIlzNlIPnn/hY495+R03dfhq
         6mJl/i60/g2ZtPVSltBrTnIEdGhZ0gqNeFTFcKh7g20pVvNNUvvy9m44m6iaEXDze5Aq
         oITH5JhsV4C6H9nvaHmPbaD/D4y/gvOAv6CXJav91XsNSnjoFUOE3xYIL2xocUSFvu0/
         A9dw==
X-Gm-Message-State: AOJu0YzAh90jIDSmZ/z0ZxY/7fmYCi9EFyo5i934pxYcMQIGXWZ/349J
        dZu4MxTJnjWDGf0WSlS7vxuTEQI6hY637ulddbtu1y6EIRgso0TT
X-Google-Smtp-Source: AGHT+IFnzEkphfcA1k56lMmjABKC+h4WWJYwladyvHeyaRQV3hNEF1Dw61zv3yr9gv0EEochrOGS5dXCs2GS30BWGs0=
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id
 m4-20020adfa3c4000000b0031ff6640d87mr7329776wrb.20.1695048675110; Mon, 18 Sep
 2023 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
In-Reply-To: <20230918-stuhl-spannend-9904d4addc93@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:51:03 +0200
Message-ID: <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 18 Sept 2023 at 16:40, Christian Brauner <brauner@kernel.org> wrote:

> What we're talking about here is a nicely typed struct which returns two
> paths @mnt_root and @mnt_point which can both be represented as u64
> pointers with length parameters like we do in other binary structs such
> as bpf and clone3 and a few others. That is a compromise I can live
> with. I'm really trying to find as much common ground here as we can.

So to be clear about your proposal: .mnt_root and .mountpoint are
initialized by the caller to buffers that the kernel can copy paths
into?

If there's an overflow (one of the buffers was too small) the syscall
returns -EOVERFLOW?

Thanks,
Miklos
