Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E132A331682
	for <lists+linux-api@lfdr.de>; Mon,  8 Mar 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCHSst (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Mar 2021 13:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCHSsh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Mar 2021 13:48:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0DC06174A;
        Mon,  8 Mar 2021 10:48:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i9so138824wml.0;
        Mon, 08 Mar 2021 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuS8Rc3UOuR98KYFxkapDvq7j5/JyhqKZORi7Tho5Yg=;
        b=VJPsnM8U+SQZvYbxIcqjwLIlrLdYPYaKz9B4xFWMl6nYW4bKg1s9v7UXx9pL7csMdj
         OK5l0yp2l9Jhrt1UXl17YNjRlFuI9EQj8pC3I+sGAzxVJHNbf9VH0OGXmvqtS/eYuc6A
         TC6aSMKmHgt0DRrPhlv5Gqj672Vgy3g4w2zU0JeWS+GClxbhhI4GI46lPntZLsk0+pEl
         ZiMOVAF0Yd8d/dDnEv27Ez+bH2WZSOnQCni4Z7xF+mwJcVz3HGBlIpirty9KFWuqo477
         iFRGFams7z7Cyo9qRhUhtOVjeqZtj6VpYEEHVmSrYhM/ROVFFi14mLFrV+zJ6nxKUFO6
         BTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuS8Rc3UOuR98KYFxkapDvq7j5/JyhqKZORi7Tho5Yg=;
        b=htUu5UZJyrNlD1zxD3vaC5ARdikDQIDeLYqh4+pb8RzP8ogN8FA3Hc1vPVISmJDE8t
         zBbviGxhC6J/eJYibPSgGmbFhDDqI/unpwAojcX2TPm+F5AnpgOM2xGKg9tYls+xiiVr
         ayC9gIS487I6nl8be1+Doz9NaKStaIe9f5AJhKCMHU1sr5M6oYQDtlUoanvvA/jkWtPI
         H9wItFNvY0G7g6rvuQKONgR+lw7SRDhucjebAVXXiMCgs8daVLr9G4Njshp0IMSvIOJ6
         ypxKKtcejUGPrx1YhrZ3afmYMlkCiai13mMkue8/8utP86FGv8XRjdhNq0V7jKzb4P6N
         zJbA==
X-Gm-Message-State: AOAM530ezuWKSvaeyF4nkGUn4le/AU5P5GEaumY3iOuplksX1OpIbT9T
        n++sbfQcgF0r5Ur66ypYwpluyTjq3fQ=
X-Google-Smtp-Source: ABdhPJxXCnDv0ks1rw5XHpNDskpWXkt3mF/Cj+hMvWBdlj5+4C7Nr0LKXEdVt8uUUF0W48Xns0WDDQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr161466wmi.127.1615229316277;
        Mon, 08 Mar 2021 10:48:36 -0800 (PST)
Received: from xws.localdomain (pd9ea322b.dip0.t-ipconnect.de. [217.234.50.43])
        by smtp.gmail.com with ESMTPSA id z3sm19758877wrw.96.2021.03.08.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:48:35 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/surface: Add DTX detachment system driver
Date:   Mon,  8 Mar 2021 19:48:16 +0100
Message-Id: <20210308184819.437438-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The Microsoft Surface Book series devices consist of a so-called
clipboard part (containing the CPU, touchscreen, and primary battery)
and a base part (containing keyboard, secondary battery, and optional
discrete GPU). These parts can be separated, i.e. the clipboard can be
detached and used as tablet.

This detachment process is managed by a subsystem of the Surface System
Aggregator Module (SSAM). As that process is a bit more complex, i.e.
can involve user interaction, it seems the best way to implement this is
to provide a somewhat cleaned-up version of this interface to userspace.

This series adds a driver (and documentation) for the detachment system
which provides such an interface. See the commit message of the first
patch for more details and a link to a user-space daemon using this
interface. Support for the Surface Book 3 is added in patch 2,
user-space API documentation in patch 3.

Regards,
Max

Maximilian Luz (3):
  platform/surface: Add DTX driver
  platform/surface: dtx: Add support for native SSAM devices
  docs: driver-api: Add Surface DTX driver documentation

 .../surface_aggregator/clients/dtx.rst        |  718 +++++++++
 .../surface_aggregator/clients/index.rst      |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 MAINTAINERS                                   |    8 +
 drivers/platform/surface/Kconfig              |   20 +
 drivers/platform/surface/Makefile             |    1 +
 drivers/platform/surface/surface_dtx.c        | 1289 +++++++++++++++++
 include/uapi/linux/surface_aggregator/dtx.h   |  146 ++
 8 files changed, 2185 insertions(+)
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/dtx.rst
 create mode 100644 drivers/platform/surface/surface_dtx.c
 create mode 100644 include/uapi/linux/surface_aggregator/dtx.h

-- 
2.30.1

