Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1919D69A
	for <lists+linux-api@lfdr.de>; Fri,  3 Apr 2020 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDCMVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 08:21:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55700 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgDCMVd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 08:21:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so6934852wmg.5;
        Fri, 03 Apr 2020 05:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pz+2GbVjb9KdHFME6XAUsd5c1DpKsAH1YaZeJS1MvmE=;
        b=hpzIRYGFb++lZENCrUbvHFdiroOdYsY9mV4gRGIhnHBXsFiXIBopSpyGuljTC3PQmc
         CohhuNuA5Yg9BxpJwyxIcjbtcO9mSJEhFBUhrmDaLppb8UMer6TqCk39Aaz7uG+swy8D
         FQSH2P9l/EoiVmXCAGzZ8VWl8HlE8WVGgqIjfdOVYfpFIgma6FktX6Slr8NO8i2ZLIUF
         gs7NBlT4qvJHXV0TFK21kkeEX9byroOfE+EF/aYpdjDW9Ux+QxzlJmiKFpINIzCXvvb6
         QRY8d4mvCLVnlP9RQt867r1Z/Ocl7fCRFZ062ksZ5h/wyRZ+Ne5cGO+y40zel1cnRiZW
         O//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pz+2GbVjb9KdHFME6XAUsd5c1DpKsAH1YaZeJS1MvmE=;
        b=evcsp9+Vz/ZfbJNaHNu83d9UNadsxdCjcH1kurj6vuVi1R3R21MOKI7LUvfc53n51a
         g66PkfKmcvrlY8KCf+QrtbDmWX/Ze2TPBHuVaMMfrn/+zz5PXMuIehwOl9PG9NjDyqqd
         DZ9H3Bu5ROzOfcwjgpVPoDx/lWECAieFDz2cSCVln2UBL7JWvkJwKFvkuuIMIYoKWG7g
         KgX9Nc02lG26xQC8lsLw2IrSih9zBVvNZoXaSOqhmSP3jxLf3/UtYf01AXCvXrNYffWl
         /6Dl3OggWXQWEC3p/DH/myDzJzScJ/dQ+TMMKylTZX7jqxj6fwPnxzt1N0yQmC6PzYVx
         +mKA==
X-Gm-Message-State: AGi0PuY4727/s5/K8BpnFDVCcv1iU06ztgJ+cXnsT7UX4Vu3pXULUy+C
        bG/uemDVVIt+nPU3/dJbKMg=
X-Google-Smtp-Source: APiQypIr2dLhrgznSXeHhpOkDGwdwZcjxnqRiFB+cDbV6IxyngpslNTJOji6xwZ5m2oBgs3m5WYaoA==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr8390754wmb.123.1585916491070;
        Fri, 03 Apr 2020 05:21:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id b5sm1656985wrs.16.2020.04.03.05.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 05:21:30 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>
To:     Andrey Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: /proc/sys/user/max_time_namespaces?
Message-ID: <0fbcb669-33a8-9730-f7fa-639707532611@gmail.com>
Date:   Fri, 3 Apr 2020 14:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dmitry, Andrei

[Andrei, I mistyped your openvz address in an email of a few minutes
ago ("[PATCH] ns: Fix time_for_children symlink"). You were CCed
on your gmail address though.]

In the namespaces(7) manual page there is documentation for 
these files:

$ ls -1 /proc/sys/user/*namespaces
/proc/sys/user/max_cgroup_namespaces
/proc/sys/user/max_ipc_namespaces
/proc/sys/user/max_mnt_namespaces
/proc/sys/user/max_net_namespaces
/proc/sys/user/max_pid_namespaces
/proc/sys/user/max_user_namespaces
/proc/sys/user/max_uts_namespaces

These files allow one to limit on the number of namespaces
of each type.

However, there is no /proc/sys/user/max_time_namespaces file.
Was this deliberate, or an oversight?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
