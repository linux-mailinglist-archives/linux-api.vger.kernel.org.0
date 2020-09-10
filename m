Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0626510E
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIJUhe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 16:37:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726855AbgIJUbU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Sep 2020 16:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599769874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oG4VtYBGXuzb613fx5hBBNMTZQ49H6hy0YeFdmvTD8g=;
        b=C9bZqdKbaeDJakDOqUDQblf0NOkQfYT97zSVih1hf2bO/l8pkg8iFkHRyRxrBG/fFCdvNT
        uT5eVNfD4jOZ+4EmKn3CxzEnkxC5L2qCs0utjj/vPfvaF7FE0JyWVtov3mcGzLEYr8Mfsm
        EuCSFdRE91WUyv/bVidX6Dv1iOF4JG0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-FHMnbu0QNo-jRi-DLf9ZHA-1; Thu, 10 Sep 2020 16:31:12 -0400
X-MC-Unique: FHMnbu0QNo-jRi-DLf9ZHA-1
Received: by mail-ed1-f71.google.com with SMTP id d13so3053909edz.18
        for <linux-api@vger.kernel.org>; Thu, 10 Sep 2020 13:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=oG4VtYBGXuzb613fx5hBBNMTZQ49H6hy0YeFdmvTD8g=;
        b=JSSrptN43R1QAl/BWbZtP2JQUINhlFwudUT9Nc/fjJKghF6A5LVEWH7v6ewkMtUaqN
         fzI5eOQiP+qewv8bjhyACdoyqpKwgNpUhwDkpSvy3PnfwdITv1Zo+HxSZHS1Lv0L1nWm
         zbkljhen+f5V4xmmpqD844eIgW9tM/O0atQTjrma38UTyIORiEW7R7Nxw8WyGJFLAV89
         6pg/UxRvW67rcmcEFN6OYrfKKvjhwE10AX9FsA47uMCA7JzGtV9aDeiScjyFprsm2GrO
         eCdYLOid/e5koHadFcAAPPouXIPzDpGEoPPW/5Z61mNGhNNru0Y4b0qdN7AOeq4qqlGK
         59QQ==
X-Gm-Message-State: AOAM533O9Fljdpb9iihbLKQ2fk0l8FK2gJNE0Bj5s2LaqnphMLpTkptX
        H/kc7HTosDBfk2CjZKb7KiVi038GfoxuyfN+xuDLDkoqdFUsge7ynYQe53iE9bsPaTx/qy49tPo
        mZvjQDjwkzOAOsumYMHGz
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr10371708ejv.221.1599769870992;
        Thu, 10 Sep 2020 13:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH4nFbqdIdClpGW3cyhzIHHW/NNlAPR9E4pCL3OlvSjq9ChPfVJPacAk9tIeJ6YFp4UpQGsg==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr10371701ejv.221.1599769870830;
        Thu, 10 Sep 2020 13:31:10 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6042.dip0.t-ipconnect.de. [91.12.96.66])
        by smtp.gmail.com with ESMTPSA id d6sm21881edm.31.2020.09.10.13.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 13:31:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device ?
Date:   Thu, 10 Sep 2020 22:31:09 +0200
Message-Id: <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> Am 10.09.2020 um 22:01 schrieb Dave Hansen <dave.hansen@intel.com>:
>=20
> =EF=BB=BFOn 9/10/20 3:20 AM, David Hildenbrand wrote:
>> I was just exploring how /sys/devices/system/memory/memoryX/phys_device
>> is/was used. It's one of these interfaces that most probably never
>> should have been added but now we are stuck with it.
>=20
> While I'm all for cleanups, what specific problems is phys_device causing?=

>=20

Mostly stumbling over it, understanding that it is basically unused with new=
 userspace for good reason, questioning its existence.

E.g., I am working on virtio-mem support for s390x. Displaying misleading/wr=
ong phys_device indications isn=E2=80=98t particularly helpful - especially o=
nce there are different ways to hotplug memory for an architecture.

> Are you hoping that we can just remove users of memoryX/* until there
> are no more left, and this is the easiest place to start?

At least reducing it to a minimum with clear semantics. Even with automatic o=
nlining there are still reasons why we need to keep the interface for now (e=
.g., reloading kexec to update the kdump headers on memory hot(un)plug). But=
 also standby memory handling on s399x requires it (->manual onlining).=

