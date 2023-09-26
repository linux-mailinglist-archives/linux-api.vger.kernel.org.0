Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21827AEEEB
	for <lists+linux-api@lfdr.de>; Tue, 26 Sep 2023 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIZOeM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Sep 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjIZOeL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Sep 2023 10:34:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A9116
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 07:34:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9cd066db5so1180359066b.0
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695738842; x=1696343642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6kk2TiTStm9eDcVWQMgpEpJ22Rj2XRqKEyxt8qhEtA=;
        b=YcIbDNgI0bkoTIo6MqWRZy2lIoQ+WPsLVAfBfdg1jzx4c8ov4uErwM4T/W+JgiLp1L
         nNOezxmiRpSSIPazwSdPNeE+u8kkNn/ddAQ2JrDEDEXH0wm0ykVUAmCPzzZID4cHGbk0
         2NpMX022JEhC2IwObveTMl2yG4f0f9ADwKLiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695738842; x=1696343642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6kk2TiTStm9eDcVWQMgpEpJ22Rj2XRqKEyxt8qhEtA=;
        b=ehrfvAAljwQ0lhg28SvemziEfMB1NWJLJ6V/ViCcD2KmqZrTirDl7Fq4bCeF/zy38x
         ogAD+PvpWw3fUZx12s39o0odCJbIUYX86xD4NXbcDal7kwERcKSra3q6t1RYLxETJOy5
         S2jsGq24c1aUnIjVaje5fFuQv7tn2OEojcrE6cms+lgw5cgrz9C3XAF0T6jZtN/AOuU+
         39OWjze6tSayz2JUcN6Ejuf3iJNbqFZmo+S7ZK4VbfEeteAPM/XDOIaDecytf1KDzq87
         bnTOzKVY36FTsbQ6SI7K9AKYOXUBUVILmcH4s0WNsFDY0B/KkO+Tl34rTsAGIuud70sp
         Idsg==
X-Gm-Message-State: AOJu0YxvSW8S7GfG0IMVXOBp9WjNzuGn5BIbUwR+EMWPvXmGFBfjph/e
        YWmTBY3/TbI3TSjt25iXa6TJrqa0qI6vpQKgE1IlcQ==
X-Google-Smtp-Source: AGHT+IHt2bDvFt+tb11SSBlcX10WiTRDs9qeZJwZanaO2Sx8L816ts304S/N3efPiDWhGQIMXUWZ03ymfrVxh3mUmFM=
X-Received: by 2002:a17:906:ae81:b0:9ae:961a:de7f with SMTP id
 md1-20020a170906ae8100b009ae961ade7fmr9336652ejb.30.1695738842442; Tue, 26
 Sep 2023 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <871qeloxj0.fsf@oldenburg.str.redhat.com> <CAJfpegupTzdG4=UwguL02c08ZaoX+UK7+=9XQ9D1G4wLMxuqFA@mail.gmail.com>
 <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 26 Sep 2023 16:33:50 +0200
Message-ID: <CAJfpegvKECAFNhWYKfGbSWVX8pycQxsHnCr6KSqrQrR+u77yAg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 26 Sept 2023 at 16:19, Florian Weimer <fweimer@redhat.com> wrote:

> getdents gets away with this buffer size because applications can copy
> out all the data from struct dirent if they need long-term storage.
> They have to do that because the usual readdir interface overwrites the
> buffer, potentially at the next readdir call.  This means the buffer
> size does not introduce an amount of memory fragmention that is
> dependent on the directory size.
>
> With an opaque, pointer-carrying struct, copying out the data is not
> possible in a generic fashion.  Only the parts that the application
> knows about can be copied out.  So I think it's desirable to have a
> fairly exact allocation.

Okay, so let's add a 'size' field to the struct, which is set to the
size used (as opposed to the size of the buffer).   That should solve
copying without wasting a single byte of memory.

Otherwise the format is fully copyable, since the strings are denoted
with an offset, which doesn't change after the buffer is copied.

Thanks,
Miklos
