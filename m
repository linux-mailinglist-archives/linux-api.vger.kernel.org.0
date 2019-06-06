Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10D37745
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfFFO5a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 10:57:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39942 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfFFO53 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Jun 2019 10:57:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so1667082pfn.7
        for <linux-api@vger.kernel.org>; Thu, 06 Jun 2019 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YAu2DH9Gh0ZQ6HRYIfl6NOBT9O8LotQbvARXbdHVaps=;
        b=1GFYjUK0Nf7MEISI0XlC9f3t4uGI4rDrxgMVMYNhf1TgM8/gH35ijWtVCk1M7MtRG1
         aEJNRIzbEEekpsV4XhSx9mVGlQvzHxu6OoDZq67iCBrFrUMDndZ1cWMv6qUM4gzIJbiU
         BkjVRFs1DTAM6qZhmH1EVu1m8577MVEZ6d3sfTAosJNHuLui7yzr8nqgnn1KmLqNXx1L
         vAxMANQZx3WrTFrCMd4dfHKDU5d1uQ6jJK01oel0e/47WrhV/2sWrQ6w/a5+JwDr8OV2
         k8iI4E1O2I83xA5gVHncyZHbFBqCH9QsBwF8kNUMpA/nhj8CapLbH3J3GByfBvxOXPcx
         67pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YAu2DH9Gh0ZQ6HRYIfl6NOBT9O8LotQbvARXbdHVaps=;
        b=BPYY3gGMrioX8fgRHqmnn3sORwgZMuvJFb4HHztc6DlvWlR9FrZY4F1Gz6EzlpDyG6
         dF8ZFE7UtB0aPiTLK/gwpnYSBKVFiv+iNSn1D3aDSRl7+YzlzQXmiq1ekkKiWuoUIGQz
         lFD3Oxyvc/25Xo8zL89xhD00pcFyS2lBxmKCwPgD+t7zavajUhRftWGSZJC29Ni4HZjt
         Kw+VfJVJsJHL7b/J9yqOsBCN3l99HiBiQFtu3mWc6E4glirASJeAk3DWbBgxNe913alL
         x1kQ5ERfMdsn2G/R65U7sDUv7BISlTyA/gbKe5ADDA3ALH/YGzmXLm7oRE4FQTS1OdMy
         7MVw==
X-Gm-Message-State: APjAAAXkLj/czy2eta3m5ZtgyJ4KHz5eSiYJv4EORii+xOjeE6i2ig8Z
        imGs2DiP1LrdsTNDm5Gsw/2fQQ==
X-Google-Smtp-Source: APXvYqz2nsMn6R+fC1rJyJ4Xnm/YQ1YKlQjcALKsq3+NEISAAm7q7sQLrssURMnK0K3bFhGsZ1lWAQ==
X-Received: by 2002:a17:90a:bb94:: with SMTP id v20mr317916pjr.88.1559833049146;
        Thu, 06 Jun 2019 07:57:29 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3cf4:ba16:ce9b:b777? ([2601:646:c200:1ef2:3cf4:ba16:ce9b:b777])
        by smtp.gmail.com with ESMTPSA id j22sm2261397pfn.121.2019.06.06.07.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:57:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last fputter's creds [ver #3]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
Date:   Thu, 6 Jun 2019 07:57:27 -0700
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 6, 2019, at 2:42 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> So that the LSM can see the credentials of the last process to do an fput(=
)
> on a file object when the file object is being dismantled, do the followin=
g
> steps:
>=20

I still maintain that this is a giant design error. Can someone at least com=
e up with a single valid use case that isn=E2=80=99t entirely full of bugs?=
